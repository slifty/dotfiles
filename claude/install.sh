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

# Symlink every file in config/ into ~/.claude/ (follows the nested-config
# pattern used by postgresql/newsyslog: leave an existing symlink alone, back
# up a real file before linking)
for src in "$DOTFILES_CLAUDE_CONFIG"/*; do
	[ -f "$src" ] || continue
	filename="$(basename "$src")"
	target="$CLAUDE_CONFIG_DIR/$filename"

	if [ -L "$target" ]; then
		info "${filename} already symlinked"
	else
		if [ -e "$target" ]; then
			warn "${filename} exists and is not a symlink, backing up"
			mv "$target" "${target}.backup"
		fi
		ln -s "$src" "$target"
		success "Symlinked ${filename}"
	fi
done

success "Claude Code configuration complete"
