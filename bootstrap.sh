#!/usr/bin/env bash
#
# bootstrap installs things.
set -e

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
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    touch git/gitconfig.local.symlink
    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

    success 'gitconfig'
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

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
  cd ~/
  git clone https://github.com/slifty/dotfiles.git .dotfiles
  cd .dotfiles
}

setup_gitconfig
install_dotfiles

# Run the pre-installers
find . -name preinstall.sh | while read installer ; do sh -c "${installer}" ; done

# Set this up as a git clone (it is assumed it started as a zip file)
setup_clone

# Run Homebrew through the Brewfile
echo "› brew bundle"
brew bundle

# find the installers and run them iteratively
find . -name install.sh | while read installer ; do sh -c "${installer}" ; done

echo ''
echo '  All installed!'


