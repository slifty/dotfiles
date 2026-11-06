#!/bin/sh

if ! command -v jq > /dev/null 2>&1; then
	echo "⚠️ jq not installed"
	exit 0
fi

account_file="${CLAUDE_CONFIG_DIR:+$CLAUDE_CONFIG_DIR/.claude.json}"
account_file="${account_file:-$HOME/.claude.json}"

jq -r '.oauthAccount // empty | "👤 \(.emailAddress) · \(.organizationName)"' "$account_file" 2> /dev/null
