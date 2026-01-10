#!/usr/bin/env bash
#
# Shared utility functions for dotfiles scripts
#
# Usage: source ~/.dotfiles/lib/functions.sh

# Output functions with color formatting
info() {
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n" >&2
	exit 1
}

warn() {
	printf "\r\033[2K  [\033[0;33mWARN\033[0m] $1\n" >&2
}

user() {
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

# Check if a command exists
# Usage: check_command git
check_command() {
	if ! command -v "$1" &> /dev/null; then
		fail "$1 is required but not installed"
	fi
}

# Require an environment variable to be set
# Usage: require_env USER_EMAIL
require_env() {
	if [ -z "${!1}" ]; then
		fail "Environment variable $1 is required but not set"
	fi
}

# Check if a file or directory exists
# Usage: check_exists ~/.ssh/config
check_exists() {
	if [ ! -e "$1" ]; then
		fail "$1 does not exist"
	fi
}
