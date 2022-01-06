## - We want to use Dropbox versions of a few key directories so they're the same across all devices
# Use sync'd Downloads
sudo rm -fr ~/Downloads
mkdir -p ~/Dropbox/Downloads
ln -s ~/Dropbox/Downloads ~/Downloads

# Use sync'd Documents
sudo rm -fr ~/Documents
mkdir -p ~/Dropbox/Documents
ln -s ~/Dropbox/Documents ~/Documents

# Use sync'd Code
ln -s ~/Dropbox/Code ~/Code