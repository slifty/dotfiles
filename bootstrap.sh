#!/usr/bin/env bash
#
# bootstrap installs things.
set +e

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info 'Setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
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

install_dotfiles () {
  info 'Installing dotfiles (symlinks)'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H ~/.dotfiles -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    echo "linking $src"
    dst="$HOME/.$(basename "${src%.*}")"
    if [ $(readlink $dst) ]
    then
      rm -fr "$dst"
    fi

    ln -s "$src" "$dst"
  done
}

setup_clone () {
  # Note: This function is not currently called by bootstrap
  # Users should manually clone the repo first following the README instructions
  cd ~/
  git clone $DOTFILES_REPO_URL .dotfiles
  cd .dotfiles
}

setup_gitconfig
install_dotfiles

# Run the pre-installers
find . -name preinstall.sh | while read installer ; do sh -c "${installer}" ; done

# Run Homebrew through the Brewfile
info "› brew bundle"
brew bundle

# find the installers and run them iteratively
find . -name install.sh | while read installer ; do sh -c "${installer}" ; done

success 'All installed!'


