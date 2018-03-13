echo "InStAlLiNg Oh My ZsH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "InStAlLiNg PoWeRlInE fOnTs"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "TuRnInG oN zSh As DeFaUlT sHeLl"
chsh -s /bin/zsh
