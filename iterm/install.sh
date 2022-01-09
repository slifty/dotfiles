#######################
# iTerm is a terminal application
#
# To view its plist (e.g. when updating this file)
# plutil -convert xml1 ~/Library/Preferences/com.googlecode.iterm2.plist
# edit ~/Library/Preferences/com.googlecode.iterm2.plist
printf "\e[32mUpdating iTerm to sync preferences with dotfiles\e[0m\n"
set -x

# Load preferences from a custom folder or URL
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string ~/.dotfiles/iterm/preferences
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true
{ set +x; } 2>/dev/null
printf "\e[32miTerm preference sync configured.\e[0m\n"
printf "\e[33m(You may need to restart iTerm for all settings to take effect)\e[0m\n"

## Everything below this line is part of an attempt to manually update preferences on a per-preference basis.
## This worked for a lot, but in particular it did not work for profiles / themes.
## iTerm really seems to NOT want to let you set all your preferences via CLI (outside of their Python API),
## and their Python API requires user interaction to enable... So here we are.  I'm including all of this in ONE
## commit so I have it in history, and then I can delete it later

#######################
## General Settings
#######################
# # (Don't) Confirm "Quit iterm2"
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false
# # (Don't) Confirm closing multiple sessions
# defaults write com.googlecode.iterm2 OnlyWhenMoreTabs -bool false
# # (Don't) adjust window when changing font size
# defaults write com.googlecode.iterm2 AdjustWindowForFontSizeChange -bool false
# # Report mouse scrolls to interactive applications (e.g. vim)
# defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true

# #######################
# ## Window Settings
# #######################
# # (Don't) show window number in title bar
# defaults write com.googlecode.iterm2 WindowNumber -bool false
# # (Don't) show border around windows
# defaults write com.googlecode.iterm2 UseBorder -bool false
# # (Don't) show border around windows
# defaults write com.googlecode.iterm2 UseBorder -bool false
# # (Don't) hide scrollbars
# defaults write com.googlecode.iterm2 HideScrollbar -bool false
# # Dim background windows
# defaults write com.googlecode.iterm2 DimBackgroundWindows -bool true
# # (Dont') dim inactive split panes
# defaults write com.googlecode.iterm2 DimInactiveSplitPanes -bool false
# # Dimming affects only text, not background
# defaults write com.googlecode.iterm2 DimOnlyText -bool true
# # Dimming amount
# defaults write com.googlecode.iterm2 SplitPaneDimmingAmount -float .20
# # Appearance => General => Theme (Minimal)
# defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5

#######################
## Profile Settings
#######################
# Ensure the DynamicProfiles directory exists
# mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
# Load our profile
# ln -s ~/.dotfiles/iterm/templates/DynamicProfiles/slifty.json "$HOME/Library/Application\ Support/iTerm2/DynamicProfiles"

#######################
## Scripts
#######################
# Ensure the Scripts directory exists
#mkdir -p "$HOME/Library/Application Support/iTerm2/Scripts"
# Load our script
#ln -s ~/.dotfiles/iterm/templates/Scripts/loadDotfileDefaults.py "$HOME/Library/Application Support/iTerm2/Scripts"

# Use the profile
#defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "4befacf4-c43a-4000-b812-11360928c99d"

