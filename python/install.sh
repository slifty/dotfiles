echo "Install latest python"
ln -s ~/.dotfiles/python/pyenv-install-latest "$(pyenv root)"/plugins/pyenv-install-latest
pyenv install-latest

echo "Installing pipenv"
pip install -U pipenv
