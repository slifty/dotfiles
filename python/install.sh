echo "Install latest python"
mkdir "$(pyenv root)"/plugins
ln -s ~/.dotfiles/python/pyenv-install-latest "$(pyenv root)"/plugins/pyenv-install-latest
pyenv install-latest

echo "Setting global python"
source ./hook.zsh
pyenv global $(get_installed_python_version)

echo "Installing pipenv"
pip install -U pipenv
