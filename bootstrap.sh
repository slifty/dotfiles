#!/usr/bin/env bash
#
# bootstrap installs things.
set +e # Keep +e so one script failure doesn't stop others

# Source shared functions
source "$(dirname "$0")/lib/functions.sh"

# Validate environment before proceeding
validate_environment() {
	info "Validating environment"

	# Check if .env file exists
	if [ ! -f ~/.dotfiles/.env ]; then
		fail ".env file not found. Copy .env.template and configure it."
	fi

	# Source .env if not already sourced
	if [ -z "$DEVICE_NAME" ] || [ -z "$USER_EMAIL" ]; then
		source ~/.dotfiles/.env
	fi

	# Validate required environment variables
	if [ -z "$USER_EMAIL" ]; then
		fail "USER_EMAIL not set in .env"
	fi

	if [ -z "$DEVICE_NAME" ]; then
		fail "DEVICE_NAME not set in .env"
	fi

	# Check if local/config.json exists
	if [ ! -f ~/.dotfiles/local/config.json ]; then
		fail "local/config.json not found. Copy local/config.json.example and configure it."
	fi

	success "Environment validated"
}

setup_gitconfig() {
	if ! [ -f git/gitconfig.local.symlink ]; then
		info 'Setup gitconfig'

		git_credential='cache'
		if [ "$(uname -s)" == "Darwin" ]; then
			git_credential='osxkeychain'
		fi

		user ' - What is your github author name?'
		read -e git_authorname
		user ' - What is your github author email?'
		read -e git_authoremail
		user ' - What is your GPG signing key ID? (Find with: gpg --list-secret-keys --keyid-format LONG)'
		read -e git_signingkey

		touch git/gitconfig.local.symlink
		sed -e "s/AUTHOR_NAME/$git_authorname/g" -e "s/AUTHOR_EMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" -e "s/GPG_SIGNING_KEY/$git_signingkey/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

		success 'gitconfig'
	fi
}

install_dotfiles() {
	info 'Installing dotfiles (symlinks)'

	local overwrite_all=false backup_all=false skip_all=false

	for src in $(find -H ~/.dotfiles -maxdepth 2 -name '*.symlink' -not -path '*.git*'); do
		echo "linking $src"
		dst="$HOME/.$(basename "${src%.*}")"
		if [ $(readlink $dst) ]; then
			rm -fr "$dst"
		fi

		ln -s "$src" "$dst"
	done
}

setup_clone() {
	# Note: This function is not currently called by bootstrap
	# Users should manually clone the repo first following the README instructions
	cd ~/
	git clone $DOTFILES_REPO_URL .dotfiles
	cd .dotfiles
}

# Track installation results
declare -a failed_scripts=()
declare -a successful_scripts=()

# Validate environment first
validate_environment

setup_gitconfig
install_dotfiles

# Run the pre-installers
info "Running pre-install scripts"
find . -name preinstall.sh | while read installer; do
	info "Running ${installer}"
	if sh -c "${installer}"; then
		success "Completed ${installer}"
	else
		warn "Failed ${installer}"
	fi
done

# Run Homebrew through the Brewfile
info "› brew bundle"
if brew bundle; then
	success "Homebrew packages installed"
else
	warn "brew bundle had errors"
fi

# Find and run the installers iteratively
info "Running install scripts"
while IFS= read -r installer; do
	info "Running ${installer}"
	if sh -c "${installer}"; then
		successful_scripts+=("$installer")
		success "Completed ${installer}"
	else
		failed_scripts+=("$installer")
		warn "Failed ${installer}"
	fi
done < <(find . -name install.sh)

# Final report
echo ""
info "Installation Summary"
echo "  Successful: ${#successful_scripts[@]}"
echo "  Failed: ${#failed_scripts[@]}"

if [ ${#failed_scripts[@]} -gt 0 ]; then
	echo ""
	warn "The following scripts failed:"
	for script in "${failed_scripts[@]}"; do
		echo "    - $script"
	done
	echo ""
	warn "Bootstrap completed with errors"
else
	echo ""
	success "All installed successfully!"
fi
