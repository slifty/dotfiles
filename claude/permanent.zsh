CLAUDE_PERMANENT_ROOT="${CLAUDE_PERMANENT_ROOT:-$HOME/Code/permanent}"
CLAUDE_PERMANENT_CONFIG_DIR="$HOME/.claude-permanent"
CLAUDE_PERMANENT_SETTINGS="$HOME/.dotfiles/claude/permanent/settings.json"
CLAUDE_PERMANENT_PLUGINS_DIR="$CLAUDE_PERMANENT_ROOT/tank/plugins"
CLAUDE_PERMANENT_PLUGINS=(
	permanent-dozer
	permanent-data
	permanent-engineering
	permanent-archive
)

claude() {
	if [[ "${PWD:A}/" != "${CLAUDE_PERMANENT_ROOT:A}/"* ]]; then
		command claude "$@"
		return
	fi

	local plugin
	local plugin_args=()
	for plugin in $CLAUDE_PERMANENT_PLUGINS; do
		plugin_args+=(--plugin-dir "$CLAUDE_PERMANENT_PLUGINS_DIR/$plugin")
	done

	CLAUDE_CONFIG_DIR="$CLAUDE_PERMANENT_CONFIG_DIR" command claude \
		--settings "$CLAUDE_PERMANENT_SETTINGS" \
		"${plugin_args[@]}" \
		"$@"
}
