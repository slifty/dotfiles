#!/usr/bin/env bash
#
# iTerm2 Configuration
#
# This script configures iTerm2 using:
# 1. Dynamic Profiles (for profile-specific settings like colors, fonts)
# 2. defaults write commands (for global behavior settings)
#
# This approach avoids tracking the entire plist file, which contains
# ephemeral state (window positions, sizes, etc.) that creates git noise.

set -e

info() {
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

printf "\e[32mConfiguring iTerm2\e[0m\n"

# ==============================================================================
# 1. Disable preference sync folder (if previously enabled)
# ==============================================================================
# iTerm2 rewrites its preferences from in-memory state on quit, which will
# clobber any `defaults write` we do here. If iTerm2 is running, warn the
# user — the settings below will only stick after a clean quit and relaunch.
if pgrep -xq iTerm2; then
	printf "\e[33m⚠️  iTerm2 is currently running.\e[0m\n"
	printf "\e[33m   It will overwrite these preferences on quit.\e[0m\n"
	printf "\e[33m   Quit iTerm2 completely, then re-run this script.\e[0m\n"
fi

info "Disabling plist sync folder..."
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool false
# Clear the stale custom folder path so iTerm2 doesn't complain about a
# missing/malformed directory on next launch.
defaults delete com.googlecode.iterm2 "PrefsCustomFolder" 2> /dev/null || true

# ==============================================================================
# 2. Set up Dynamic Profiles
# ==============================================================================
info "Setting up Dynamic Profiles..."

# Create DynamicProfiles directory if it doesn't exist
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles/

# Symlink our dotfiles profiles
if [ -L ~/Library/Application\ Support/iTerm2/DynamicProfiles/dotfiles-profiles.json ]; then
	rm ~/Library/Application\ Support/iTerm2/DynamicProfiles/dotfiles-profiles.json
fi

ln -s ~/.dotfiles/iterm/profiles/Default.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/dotfiles-profiles.json
success "Dynamic Profiles configured"

# ==============================================================================
# 3. Apply global settings
# ==============================================================================
info "Applying global settings..."
chmod +x ~/.dotfiles/iterm/settings.sh
~/.dotfiles/iterm/settings.sh

# ==============================================================================
# Done
# ==============================================================================
printf "\e[32miTerm2 configuration complete!\e[0m\n"
printf "\e[33m⚠️  You MUST restart iTerm2 for changes to take effect\e[0m\n"
printf "\e[33m⚠️  After restarting, you may need to select the 'Default' profile in Preferences > Profiles\e[0m\n"
