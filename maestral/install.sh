# Set up Maestral
mkdir ~/Maestral
ln -s ~/.dotfiles/maestral/.mignore ~/Maestral/.mignore
fileicon set ~/Maestral/ /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/LibraryFolderIcon.icns

## - We want to use Dropbox versions of a few key directories so they're the same across all devices
# Use sync'd Downloads
sudo rm -fr ~/Downloads
mkdir -p ~/Maestral/Downloads
ln -s ~/Maestral/Downloads ~/Downloads
fileicon set ~/Maestral/Downloads/ /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DownloadsFolder.icns

# Use sync'd Documents
sudo rm -fr ~/Documents
mkdir -p ~/Maestral/Documents
ln -s ~/Maestral/Documents ~/Documents
fileicon set ~/Maestral/Documents/ /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DocumentsFolderIcon.icns

# Use sync'd Code
mkdir -p ~/Maestral/Code
ln -s ~/Maestral/Code ~/Code
fileicon set ~/Maestral/Code/ /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DeveloperFolderIcon.icns

# Check out this https://gist.github.com/korylprince/be2e09e049d2fd721ce769770d983850
