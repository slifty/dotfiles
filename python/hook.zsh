get_installed_python_version() {
  local query=$1
  pyenv versions 2> /dev/null \
    | grep -E "(^\*?\s*$query\.)|(^\*?\s*$query)" \
    | sed 's/^\s\+//' \
    | sed 's/(.*)//' \
    | sed 's/\*//' \
    | sort -V \
    | tail -1 \
    | xargs
}

get_latest_available_python_version() {
  local query=$1
  pyenv install --list \
    | grep -vE "(^Available versions:|-src|dev|rc|alpha|beta|(a|b)[0-9]+)" \
    | grep -E "(^\s*$query\.)|(^\s*$query$)" \
    | sed 's/^\s\+//' \
    | tail -1 \
    | xargs
}

# This hook relies on the install-latest pyenv plugin:
#
# https://github.com/momo-lab/pyenv-install-latest
# 
# The hook will install the .python-version if it isn't already installed.
# If an improperly unspecific version of python is provided this will also correct
# the .python-version file to something pyenv accepts.
# When correcting, if there is an already installed version that matches the goal it
# will use that installed version, otherwise it will install the latest version of whatever
# is specified in .python-version.
autoload_python_version() {
  local python_version="$(pyenv version-name)"
  local python_version_path=".python-version"
  if [ -f "$python_version_path" ]; then
    local pyenv_target_version=$(cat "${python_version_path}")
    local pyenv_installed_target_version=$(get_installed_python_version $pyenv_target_version)
    local pyenv_latest_available_target_version=$(get_latest_available_python_version $pyenv_target_version)
    if [ -z "$pyenv_installed_target_version" ]; then
      echo "\e[32mAutomatically installing the latest version of Python $pyenv_target_version\e[0m"
      pyenv install-latest "$pyenv_target_version"
      pyenv_installed_target_version=$(get_installed_python_version $pyenv_target_version)
    fi
    if [ -z "$pyenv_installed_target_version" ]; then
      echo "\e[91mCould not install Python $pyenv_latest_available_target_version."
    elif [ "$pyenv_target_version" != "$pyenv_installed_target_version" ]; then
      echo "\e[91mCorrecting your .python-version from $pyenv_target_version to $pyenv_installed_target_version (it must match an installed version)\e[0m"
      if [ "$pyenv_installed_target_version" != "$pyenv_latest_available_target_version" ]; then
        echo "\e[33mIf you wanted the latest Python $pyenv_target_version type:\e[0m pyenv install $pyenv_latest_available_target_version"
      else
        echo "\e[33mPython $pyenv_installed_target_version is the latest version of Python $pyenv_target_version available\e[0m"
      fi
      pyenv local "$(get_installed_python_version $pyenv_target_version)" 2> /dev/null
    fi
  fi
}
add-zsh-hook chpwd autoload_python_version
autoload_python_version