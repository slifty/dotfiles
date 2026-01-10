#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

# Validate required environment variables
require_env USER_EMAIL

SSH_KEY="$HOME/.ssh/id_ed25519"

# Ensure .ssh directory exists
if [ ! -d "$HOME/.ssh" ]; then
	info "Creating .ssh directory"
	mkdir -p "$HOME/.ssh"
	chmod 700 "$HOME/.ssh"
fi

# Check if the key already exists
if [ ! -f "$SSH_KEY" ]; then
	info "SSH key not found. Generating a new one..."
	if ssh-keygen -t ed25519 -C "$USER_EMAIL" -f "$SSH_KEY" -N ""; then
		success "SSH key generated at $SSH_KEY"
	else
		fail "Failed to generate SSH key"
	fi
else
	info "SSH key already exists at $SSH_KEY"
	success "SSH key configured"
fi
