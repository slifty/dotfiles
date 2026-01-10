#!/usr/bin/env bash
#
# iTerm2 Global Settings
#
# This file contains curated iTerm2 global preferences that should be
# version controlled and applied across machines. It does NOT include
# ephemeral state like window positions, sizes, or recent history.
#
# These settings are applied using macOS defaults commands.

set -e

info() {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

info "Applying iTerm2 global settings..."

# ==============================================================================
# General Preferences
# ==============================================================================

# Don't prompt on quit
defaults write com.googlecode.iterm2 "PromptOnQuit" -bool false

# Only prompt to quit if more than one tab (safer option if you prefer)
# defaults write com.googlecode.iterm2 "OnlyWhenMoreTabs" -bool true

# Dim inactive panes (text only)
defaults write com.googlecode.iterm2 "DimOnlyText" -bool true

# ==============================================================================
# Appearance
# ==============================================================================

# Hide tab bar when there's only one tab
# defaults write com.googlecode.iterm2 "HideTab" -bool true

# Tab style (0=Light, 1=Dark, 2=Light with dark background, 3=Dark with light background)
# defaults write com.googlecode.iterm2 "TabStyle" -int 1

# Status bar location (0=Bottom, 1=Top)
# defaults write com.googlecode.iterm2 "StatusBarPosition" -int 0

# ==============================================================================
# Window Behavior
# ==============================================================================

# Adjust window when changing font size
# defaults write com.googlecode.iterm2 "AdjustWindowForFontSizeChange" -bool true

# Native full screen windows
# defaults write com.googlecode.iterm2 "UseLionStyleFullscreen" -bool true

# ==============================================================================
# Performance
# ==============================================================================

# GPU rendering (may need to be disabled on some systems)
# defaults write com.googlecode.iterm2 "UseMetal" -bool true

# ==============================================================================
# Keyboard
# ==============================================================================

# Left Option key acts as Meta
# defaults write com.googlecode.iterm2 "Optionkeyasmetaforleftoption" -bool true

# Right Option key acts as Meta
# defaults write com.googlecode.iterm2 "Optionkeyasmetaforrightoption" -bool true

# ==============================================================================
# Advanced
# ==============================================================================

# Trim whitespace on copy
# defaults write com.googlecode.iterm2 "TrimWhitespaceOnCopy" -bool true

# Save copy/paste history
# defaults write com.googlecode.iterm2 "SavePasteAndCommandHistory" -bool false

# ==============================================================================
# Device-Specific Settings
# ==============================================================================

# You can add device-specific overrides here by checking $DEVICE_NAME
# from your .env file. For example:
#
# if [ "$DEVICE_NAME" = "MyLaptop" ]; then
#   defaults write com.googlecode.iterm2 "SomeSetting" -string "laptop-value"
# elif [ "$DEVICE_NAME" = "MyDesktop" ]; then
#   defaults write com.googlecode.iterm2 "SomeSetting" -string "desktop-value"
# fi

success "iTerm2 global settings applied"

# Note: iTerm2 needs to be restarted for many settings to take effect
