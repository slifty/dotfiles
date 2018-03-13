echo "SeTtInG Up SuBlImE."
rm -fr ~/Library/Application\ Support/Sublime\ Text 3/Packages
mv Package\ Control.sublime-package ~/Library/Application\ Support/Sublime\ Text 3/Installed\ Packages
ln -s .sublime/Packages ~/Library/Application\ Support/Sublime\ Text 3

echo "SeTtInG Up CoDeInTeL."
sudo pip install --upgrade --pre --ignore-installed CodeIntel
