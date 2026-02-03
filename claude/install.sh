#!/usr/bin/env bash
#
# Claude Code installation and configuration
#
set -e
source ~/.dotfiles/lib/functions.sh

CLAUDE_CONFIG_DIR="$HOME/.claude"
DOTFILES_CLAUDE_CONFIG="$HOME/.dotfiles/claude/config"

# Install Claude Code via native installer
if ! command -v claude &> /dev/null; then
	info "Installing Claude Code"
	curl -fsSL https://claude.ai/install.sh | bash
	success "Claude Code installed"
else
	info "Claude Code already installed, checking for updates"
	# Claude auto-updates, but we can trigger a check
	claude --version || true
	success "Claude Code is installed"
fi

# Set up configuration symlinks
info "Setting up Claude Code configuration"

# Create ~/.claude directory if it doesn't exist
if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
	mkdir -p "$CLAUDE_CONFIG_DIR"
fi

# Symlink settings.json
if [ -f "$DOTFILES_CLAUDE_CONFIG/settings.json" ]; then
	if [ -L "$CLAUDE_CONFIG_DIR/settings.json" ]; then
		rm "$CLAUDE_CONFIG_DIR/settings.json"
	elif [ -f "$CLAUDE_CONFIG_DIR/settings.json" ]; then
		warn "Existing settings.json found, backing up to settings.json.backup"
		mv "$CLAUDE_CONFIG_DIR/settings.json" "$CLAUDE_CONFIG_DIR/settings.json.backup"
	fi
	ln -s "$DOTFILES_CLAUDE_CONFIG/settings.json" "$CLAUDE_CONFIG_DIR/settings.json"
	success "Symlinked settings.json"
fi

success "Claude Code configuration complete"
