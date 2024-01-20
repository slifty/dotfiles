# We want GPG to prompt for passphrases when needed, even if the call is coming from
# inside another process.
export GPG_TTY=$(tty)
