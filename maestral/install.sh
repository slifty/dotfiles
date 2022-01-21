# Set up Maestral
mkdir ~/Maestral
ln -s ~/.dotfiles/maestral/.mignore ~/Maestral/.mignore

## - We want to use Dropbox versions of a few key directories so they're the same across all devices
# Use sync'd Downloads
sudo rm -fr ~/Downloads
mkdir -p ~/Maestral/Downloads
ln -s ~/Maestral/Downloads ~/Downloads

# Use sync'd Documents
sudo rm -fr ~/Documents
mkdir -p ~/Maestral/Documents
ln -s ~/Maestral/Documents ~/Documents

# Use sync'd Code
mkdir -p ~/Maestral/Code
ln -s ~/Maestral/Code ~/Code
