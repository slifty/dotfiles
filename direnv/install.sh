#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

info "Setting up direnv"

# Create config directory if it doesn't exist
if [ ! -d ~/.config/direnv ]; then
	mkdir -p ~/.config/direnv
fi

# Create symlink if it doesn't exist
if [ ! -L ~/.config/direnv/direnv.toml ]; then
	ln -s ~/.dotfiles/direnv/direnv.toml ~/.config/direnv/direnv.toml
	success "direnv config linked"
else
	info "direnv config already linked"
fi
