# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.
printf "\e[32mRunning MacOS setup\e[0m\n"
set -x
sudo softwareupdate -i -a

# To look up the install ID go to the store and "copy link"
# and pull it from the URL
mas install 1303222628 # Paprika Recipe Manager 3 (3.2.3)
mas install 904280696 # Things3 (3.4.1)
mas install 405399194 # Kindle (1.21.1)
mas install 407963104 # Pixelmator (3.7)
mas install 992076693 # MindNode (2.5.7)
mas install 880001334 # Reeder (3.1.2)
mas install 506189836 # Harvest (2.1.5)
mas install 1091189122 # Bear (1.4.3)
mas install 409183694 # Keynote (8.1)
mas install 497799835 # XCode (9.4.1)

#######################
## Desktop Background
#######################
# Add the DotfileBackgrounds directory to the preference pane because we're just that detail oriented
defaults write com.apple.systempreferences DSKDesktopPrefPane "<dict><key>UserFolderPaths</key><array><string>$HOME/.dotfiles/macos/DotfileBackgrounds</string></array></dict>"
# Set Desktop Background
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/.dotfiles/macos/DotfileBackgrounds/ZeldaGhib.heic\" as POSIX file"

{ set +x; } 2>/dev/null
printf "\e[32mMacOS settings updated.\e[0m\n"
printf "\e[33m(You may need to restart for all settings to take effect)\e[0m\n"
