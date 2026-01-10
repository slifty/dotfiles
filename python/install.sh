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

# Check if we need to install the latest python
LATEST_VERSION=$(pyenv install-latest --print)
if ! pyenv versions --bare | grep -q "^${LATEST_VERSION}$"; then
	info "Installing Python ${LATEST_VERSION}"
	pyenv install-latest
else
	info "Python ${LATEST_VERSION} already installed"
fi

info "Setting global python"
source ./hook.zsh
pyenv global $(get_installed_python_version)

# Install pipenv if not already installed or upgrade if needed
if ! command -v pipenv &> /dev/null; then
	info "Installing pipenv"
	pip install pipenv
else
	info "Updating pipenv"
	pip install -U pipenv
fi

success "Python environment configured"
