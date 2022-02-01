############
## General Settings
############
# Hide the "welcome" message on launch
defaults write com.swinsian.Swinsian SUHasLaunchedBefore 1
# Use alubm artist tags
defaults write com.swinsian.Swinsian PreferAlbumArtistTag 1
defaults write com.swinsian.Swinsian OrganiseLibraryByAlbumArtist 1

############
## Set up network drive
############
# Use our network drive for the music library
defaults write com.swinsian.Swinsian LocalFileSaveLocation "$HOME/Volumes/synology/music"
# Watch the network drive
defaults write com.swinsian.Swinsian WatchedFolders "({CacheUUID = \"A4A62D9F-E0F3-4F8A-85ED-FBB4C5B57B23\";\"Copy Files Option\" = AddFiles;NetworkVolume = 1;\"Relative Directory Path\" = \"$HOME/Volumes/synology/music\";})"
# Check every 15 minutes
defaults write com.swinsian.Swinsian WatchedNetworkFolderCheckFreq 15
