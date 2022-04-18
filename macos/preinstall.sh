# Install Rosetta on M1 macs
if [[ $(uname -m) == 'arm64' ]]; then
  softwareupdate --install-rosetta
fi

