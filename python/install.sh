#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

# Validate pyenv is installed
check_command pyenv

info "Setting up pyenv plugin"
PYENV_PLUGINS_DIR="$(pyenv root)/plugins"
PLUGIN_NAME="pyenv-install-latest"

# Create plugins directory if it doesn't exist
if [ ! -d "$PYENV_PLUGINS_DIR" ]; then
	mkdir -p "$PYENV_PLUGINS_DIR"
fi

# Create symlink if it doesn't exist
if [ ! -L "$PYENV_PLUGINS_DIR/$PLUGIN_NAME" ]; then
	ln -s ~/.dotfiles/python/$PLUGIN_NAME "$PYENV_PLUGINS_DIR/$PLUGIN_NAME"
fi

info "Installing latest python"
pyenv install-latest

info "Setting global python"
source ./hook.zsh
pyenv global $(get_installed_python_version)

info "Installing pipenv"
pip install -U pipenv

success "Python environment configured"
