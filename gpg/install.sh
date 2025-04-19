echo "setting up gpg"
mkdir ~/.gnupg
ln -s ~/.dotfiles/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent