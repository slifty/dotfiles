# Make sure our bin files are placed where we expect (this is added to path in ./path.zsh)
ln -ns ~/.dotfiles/bin $HOME/bin

# Open things that need to be opened once in order to boot on load
open /Applications/Rectangle.app
open /Applications/SoundSource.app