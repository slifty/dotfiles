#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

check_command gpgconf

info "Setting up GPG"

# Create .gnupg directory if it doesn't exist
if [ ! -d ~/.gnupg ]; then
	mkdir ~/.gnupg
	chmod 700 ~/.gnupg
fi

# Create symlink if it doesn't exist
if [ ! -L ~/.gnupg/gpg-agent.conf ]; then
	ln -s ~/.dotfiles/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
fi

# Kill and restart gpg-agent
gpgconf --kill gpg-agent

success "GPG configured"
