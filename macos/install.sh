# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.
printf "\e[32mRunning MacOS setup\e[0m\n"
set -x
sudo softwareupdate -i -a

# To look up the install ID go to the store and "copy link"
# and pull it from the URL
mas install 411643860 # DaisyDisk (4.4)
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


#############
## Set some defaults
## This is a really handy resource to see what's possible: https://macos-defaults.com
#############

#######################
## Desktop Background
#######################
# Add the DotfileBackgrounds directory to the preference pane because we're just that detail oriented
defaults write com.apple.systempreferences DSKDesktopPrefPane "<dict><key>UserFolderPaths</key><array><string>$HOME/.dotfiles/macos/DotfileBackgrounds</string></array></dict>"
# Set Desktop Background
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/.dotfiles/macos/DotfileBackgrounds/ZeldaGhib.heic\" as POSIX file"

#######################
## "Global" Settings
#######################
# Make the highlight color a nice light blue
defaults write NSGlobalDomain AppleHighlightColor -string "0.064700 0.568600 0.996500"
# Disable default of saving to iCloud
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool false
# Remove the toolbar title rollover delay
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float 0
# Set sidebar icon size (S: 1, M: 2, L: 3)
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int 1

#######################
## Dock Settings
#######################
# Stop the super-needy bouncing icons when an app has an alert
defaults write com.apple.dock no-bouncing -bool true
# Render the dock on the right
defaults write com.apple.dock orientation right
# Set the icon size of Dock items to 52 pixels
defaults write com.apple.dock tilesize -int 52
# Don't show recent applications in the dock
defaults write com.apple.dock show-recents false
# Don't allow dock resize
defaults write com.apple.Dock size-immutable -bool true
# Show the app switcher on all displays
defaults write com.apple.Dock appswitcher-all-displays -bool true
# Reset default persistant applications
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/1Password 7.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Calendar.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/OmniFocus.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Firefox.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Zulip.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Discord.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/zoom.us.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Ableton Live 11 Suite.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/OBS.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Loopback.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Audio Hijack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
# Reset persistant dock folders
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///$HOME/Maestral/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>3</integer><key>displayas</key><integer>1</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///$HOME/Maestral/Documents/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>3</integer><key>displayas</key><integer>1</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
# Restart Dock
killall Dock

#######################
## Finder Settings
#######################
# Add a "Quit" option to Finder
defaults write com.apple.finder "QuitMenuItem" -bool true
# Show all file extensions inside Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool true
# Show hidden files in Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool true
# Disable warning when changing a file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool false
# Don't show any icons on the desktop
defaults write com.apple.finder CreateDesktop false
# Show the path bar
defaults write com.apple.finder ShowPathBar true
# Show the status bar
defaults write com.apple.finder ShowStatusBar true
# Set the default sidebar width
defaults write com.apple.f SidebarWidth 200
# Restart Finder
killall Finder

#######################
## Set up login / launch script
#######################
# Generate the launch script
envsubst < ~/.dotfiles/macos/templates/launch.sh.template > ~/.dotfiles/local/launch.sh
chmod 755 ~/.dotfiles/local/launch.sh
# Generate the autoMount script
node scripts/generateAutoMountScript.js
# Generate the launch agent
envsubst < ~/.dotfiles/macos/templates/dotfiles.macos.launch.plist.template > ~/Library/LaunchAgents/dotfiles.macos.launch.plist
# Install the launch agent
sudo launchctl load ~/Library/LaunchAgents/dotfiles.macos.launch.plist
# Run the launch script once
~/.dotfiles/local/launch.sh

#######################
## Set up auto mount drives
#######################
# sudo touch /etc/auto_smb
# sudo chmod 777 /etc/auto_master
# sudo chmod 777 /etc/auto_smb
# node ./installScripts/setUpAutoMount.js
# sudo chmod 644 /etc/auto_master
# sudo chmod 644 /etc/auto_smb

{ set +x; } 2>/dev/null
printf "\e[32mMacOS settings updated.\e[0m\n"
printf "\e[33m(You may need to restart for all settings to take effect)\e[0m\n"
