# Set up python path
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# This relies on pyenv init to function, so it doesn't go in a separate path.zsh file
export PATH="$(pyenv root)/shims:$PATH"
