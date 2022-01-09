#######################
# iTerm is a terminal application
#
# It has a few ways to specify preferences, but the way I've landed on is the use
# of a preference sync folder that points to our dotfiles.
#
# This may end up being noisy, as preferences seem to be written simply from interacting with the iTerm UI
# but it does, at least, appear to work.
printf "\e[32mUpdating iTerm to sync preferences with dotfiles\e[0m\n"
set -x

defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string ~/.dotfiles/iterm/preferences
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true

{ set +x; } 2>/dev/null
printf "\e[32miTerm preference sync configured.\e[0m\n"
printf "\e[33m(You may need to restart iTerm for all settings to take effect)\e[0m\n"

