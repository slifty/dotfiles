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
mas install 1289583905 # Pixelmator Pro
mas install 992076693 # MindNode (2.5.7)
mas install 880001334 # Reeder (3.1.2)
mas install 1091189122 # Bear (1.4.3)
mas install 409183694 # Keynote (8.1)
mas install 497799835 # XCode (9.4.1)

#############
## Set some defaults
## This is a really handy resource to see what's possible: https://macos-defaults.com
#############

#######################
## Device Name
#######################
echo "🛠 Setting system names to '$DEVICE_NAME'..."
sudo scutil --set ComputerName "$DEVICE_NAME"
sudo scutil --set HostName "$DEVICE_NAME"
sudo scutil --set LocalHostName "$DEVICE_NAME"

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
defaults write NSGlobalDomain AppleHighlightColor -string "0.064700 0.568600 0.996500 Other"
# Disable default of saving to iCloud
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool false
# Remove the toolbar title rollover delay
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float 0
# Set sidebar icon size (S: 1, M: 2, L: 3)
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int 1
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a faster key repeat rate
defaults write -g KeyRepeat -int 1 # Requires a restart to work
# Lower the delay before key repeat starts
defaults write -g InitialKeyRepeat -int 15 # Requires a restart to work
# Disable automatic text corrections
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
# Put displays to sleep on bottom left corner
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0

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
defaults write com.apple.dock show-recents -bool false
# Don't allow dock resize
defaults write com.apple.Dock size-immutable -bool true
# Show the app switcher on all displays
defaults write com.apple.Dock appswitcher-all-displays -bool true
# Reset default persistant applications
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Bitwarden.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Calendar.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/OmniFocus.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Thunderbird.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Swinsian.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Firefox.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Zulip.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Discord.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/zoom.us.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/VSCodium.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# Reset persistant dock folders
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///$HOME/Maestral/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>3</integer><key>displayas</key><integer>1</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///$HOME/Maestral/Documents/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>3</integer><key>displayas</key><integer>1</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"

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
# Show the path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Use list view in all Finder windows by default
# (Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Show the ~/Library folder
chflags nohidden ~/Library
# Show the /Volumes folder
sudo chflags nohidden /Volumes
# Open new windows to home directory
defaults write com.apple.finder NewWindowTarget "Pfhm"
defaults write com.apple.finder NewWindowTargetPath "file://$HOME/"

#######################
## Disable Apple AI
#######################
defaults write com.apple.CloudSubscriptionFeatures.optIn 545129924 -bool false
defaults write com.apple.CloudSubscriptionFeatures.optIn 102466495 -bool false
defaults write com.apple.gms.availability "com.apple.gms.availability.reasons" -array 9
defaults write com.apple.gms.availability "com.apple.gms.availability.key" -array 2
defaults write com.apple.gms.availability "com.apple.gms.availability.gpEverInstalled" -bool false
defaults write com.apple.gms.availability "com.apple.gms.availability.wasAvailable" -bool false

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

#######################
## Set default applications for various file types
##
## Note to get the app ID of an application type:
## osascript -e 'id of app "$appName"'
#######################
duti -s com.vscodium css all
duti -s com.vscodium csv all
duti -s com.vscodium env all
duti -s com.vscodium html all
duti -s com.vscodium js all
duti -s com.vscodium jsx all
duti -s com.vscodium json all
duti -s com.vscodium md all
duti -s com.vscodium php all
duti -s com.vscodium sh all
duti -s com.vscodium ts all
duti -s com.vscodium tsx all
duti -s com.vscodium txt all
duti -s com.vscodium yml all
duti -s com.vscodium yaml all
duti -s com.vscodium xml all

#######################
## Set default browser
#######################
duti -s org.mozilla.firefox http

#######################
##  Disable tiling behaviors
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# Restart modified services
killall SystemUIServer
killall Finder
killall Dock
