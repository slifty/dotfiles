echo "Setting up Sublime."
rm -fr ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
mv ~/.sublime/Package\ Control.sublime-package ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
ln -s ~/.sublime/Packages ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
