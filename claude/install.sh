#!/usr/bin/env bash
#
# Claude Code installation and configuration
#
set -e
source ~/.dotfiles/lib/functions.sh

CLAUDE_CONFIG_DIR="$HOME/.claude"
DOTFILES_CLAUDE_CONFIG="$HOME/.dotfiles/claude/config"
DOTFILES_CLAUDE_PERMANENT="$HOME/.dotfiles/claude/permanent"
CLAUDE_PERMANENT_CONFIG_DIR="$HOME/.claude-permanent"

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

# Leave an existing symlink alone and back up a real file before linking
# (the nested-config pattern used by postgresql/newsyslog)
link_config() {
	src="$1"
	target="$2"
	name="${target#$HOME/}"

	if [ -L "$target" ]; then
		info "${name} already symlinked"
	else
		if [ -e "$target" ]; then
			warn "${name} exists and is not a symlink, backing up"
			mv "$target" "${target}.backup"
		fi
		ln -s "$src" "$target"
		success "Symlinked ${name}"
	fi
}

for src in "$DOTFILES_CLAUDE_CONFIG"/*; do
	[ -f "$src" ] || continue
	link_config "$src" "$CLAUDE_CONFIG_DIR/$(basename "$src")"
done

# The Permanent profile shares the base settings and project history, and
# imports the base CLAUDE.md from its own
info "Setting up the Permanent Claude Code profile"
mkdir -p "$CLAUDE_PERMANENT_CONFIG_DIR"
link_config "$DOTFILES_CLAUDE_CONFIG/settings.json" "$CLAUDE_PERMANENT_CONFIG_DIR/settings.json"
link_config "$DOTFILES_CLAUDE_PERMANENT/CLAUDE.md" "$CLAUDE_PERMANENT_CONFIG_DIR/CLAUDE.md"
mkdir -p "$CLAUDE_CONFIG_DIR/projects"
link_config "$CLAUDE_CONFIG_DIR/projects" "$CLAUDE_PERMANENT_CONFIG_DIR/projects"

success "Claude Code configuration complete"
