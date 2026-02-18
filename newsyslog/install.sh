#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

NEWSYSLOG_D="/etc/newsyslog.d"
DOTFILES_NEWSYSLOG=~/.dotfiles/newsyslog

check_exists "$NEWSYSLOG_D"

info "Configuring newsyslog"

for conf_file in "$DOTFILES_NEWSYSLOG"/*.conf; do
	filename="$(basename "$conf_file")"
	target="${NEWSYSLOG_D}/${filename}"

	if [ -L "$target" ]; then
		info "${filename} already symlinked"
	else
		if [ -e "$target" ]; then
			warn "${filename} exists and is not a symlink, backing up"
			sudo mv "$target" "${target}.backup"
		fi
		info "Symlinking ${filename} (requires sudo)"
		sudo ln -s "$conf_file" "$target"
		success "Symlinked ${filename}"
	fi
done

success "newsyslog configured"
