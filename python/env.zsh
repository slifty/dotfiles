# Set up python path
eval "$(pyenv init -)"

# This relies on pyenv init to function, so it doesn't go in a separate path.zsh file
export PATH="$(pyenv root)/shims:$PATH"
