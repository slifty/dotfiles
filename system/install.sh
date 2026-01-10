#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

info "Setting up system configuration"

# Make sure our bin files are placed where we expect (this is added to path in ./path.zsh)
if [ ! -L $HOME/bin ]; then
	ln -ns ~/.dotfiles/bin $HOME/bin
	success "bin directory linked"
else
	info "bin directory already linked"
fi

# Open things that need to be opened once in order to boot on load
# Only open if not already running
if ! pgrep -x "Rectangle" > /dev/null; then
	info "Opening Rectangle for first-time setup"
	open /Applications/Rectangle.app
fi

if ! pgrep -x "SoundSource" > /dev/null; then
	info "Opening SoundSource for first-time setup"
	open /Applications/SoundSource.app
fi

success "System configuration complete"
