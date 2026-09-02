#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

# Make sure our bin files are placed where we expect (this is added to path in ./path.zsh)
if [ -L "$HOME/bin" ]; then
	info 'bin is already linked'
else
	info 'Linking bin'
	ln -ns ~/.dotfiles/bin "$HOME/bin"
fi

# Open things that need to be opened once in order to boot on load
for app in Rectangle SoundSource; do
	if [ -d "/Applications/$app.app" ]; then
		open "/Applications/$app.app"
	else
		warn "$app is not installed, skipping"
	fi
done

success 'System setup complete'
