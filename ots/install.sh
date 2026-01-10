#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

info "Setting up OTS configuration"

# Set up SVN
if [ -f ~/.subversion/servers ]; then
	# Check if OTS group already exists
	if ! grep -q "ots = svn.opentechstrategies.com" ~/.subversion/servers; then
		info "Adding OTS to SVN servers"
		sed -i '' '/^\[groups\]$/a\'$'\n''ots = svn.opentechstrategies.com'$'\n' ~/.subversion/servers
	fi

	# Check if OTS username already set
	if ! grep -q "^\[ots\]" ~/.subversion/servers; then
		info "Adding OTS username to SVN config"
		echo '[ots]'$'\n''username = dan' >> ~/.subversion/servers
	fi
else
	warn "~/.subversion/servers not found. Run svn once to generate it."
fi

# Set up the password store
if [ ! -d ~/.password-store ]; then
	info "Creating password store"
	mkdir ~/.password-store
	chmod go-rwx ~/.password-store
	mkdir ~/.password-store/.extensions

	# Download git-svn extension
	curl https://code.librehq.com/ots/pass-git-svn/-/raw/username/git-svn.bash \
		> ~/.password-store/.extensions/git-svn.bash
	chmod a+x ~/.password-store/.extensions/git-svn.bash

	# Clone the password store
	pass git-svn clone https://svn.opentechstrategies.com/repos/ots/trunk/.password-store ~/.password-store
	success "Password store cloned"
else
	info "Password store already exists"
fi

success "OTS configuration complete"
