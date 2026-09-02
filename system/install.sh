#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

# Make sure our bin files are placed where we expect (this is added to path in ./path.zsh)
if [ -L "$HOME/bin" ]; then
	info 'bin is already linked'
else
	# A real bin would otherwise swallow the symlink as $HOME/bin/bin
	if [ -e "$HOME/bin" ]; then
		if [ -e "$HOME/bin.backup" ]; then
			fail 'bin exists and bin.backup is already taken, move one aside first'
		fi
		warn 'bin exists and will be replaced with a symlink'
		info 'Backing up existing bin to bin.backup'
		mv "$HOME/bin" "$HOME/bin.backup"
	fi

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
