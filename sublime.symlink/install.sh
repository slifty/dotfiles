if test ! $(which spoof)
then
  rm ".sublime/install.sh"
  echo "SeTtInG Up SuBlImE."
  link_file ".sublime/Packages" "~/Library/Application Support/Sublime Text 3/Packages"

  echo "SeTtInG Up CoDeInTeL."
  pip install --upgrade --pre CodeIntel
fi
