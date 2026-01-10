#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

check_command rbenv

RUBY_VERSION="2.7.1"

info "Installing Ruby ${RUBY_VERSION}"

# Check if the version is already installed
if rbenv versions | grep -q "$RUBY_VERSION"; then
	info "Ruby ${RUBY_VERSION} already installed"
else
	rbenv install "$RUBY_VERSION"
fi

info "Setting global Ruby version to ${RUBY_VERSION}"
rbenv global "$RUBY_VERSION"

success "Ruby environment configured"
