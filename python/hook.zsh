# Load the right python at all times
load-python-version() {
  local python_version="$(pyenv version-name)"
  local python_version_path=".python-version"
  if [ -f "$python_version_path" ]; then
    local pyenv_target_version=$(cat "${python_version_path}")
    local pyenv_python_version=$(pyenv version-name)
    if [ "$pyenv_python_version" != "$pyenv_target_version" ]; then
      echo "Installing Python $pyenv_target_version"
      pyenv install "$pyenv_target_version"
      pyenv local "$pyenv_target_version"
    fi
  fi
}
add-zsh-hook chpwd load-python-version
load-python-version