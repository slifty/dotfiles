#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

check_command brew

# Determine the PostgreSQL data directory
PG_DATA="$(brew --prefix)/var/postgres"
PG_CONF="${PG_DATA}/postgresql.conf"
CONF_D="${PG_DATA}/conf.d"
DOTFILES_CONF_D=~/.dotfiles/postgresql/conf.d

check_exists "$PG_CONF"

# Set up conf.d include directory
info "Configuring PostgreSQL conf.d"

if [ ! -d "$CONF_D" ]; then
	mkdir -p "$CONF_D"
	success "Created ${CONF_D}"
fi

# Enable include_dir in postgresql.conf if not already enabled
if ! grep -q "^include_dir = 'conf.d'" "$PG_CONF"; then
	info "Enabling conf.d include directory in postgresql.conf"
	echo "" >> "$PG_CONF"
	echo "include_dir = 'conf.d'" >> "$PG_CONF"
	success "Enabled conf.d include directory"
else
	info "conf.d include directory already enabled"
fi

# Symlink config files from dotfiles conf.d into the PostgreSQL conf.d
for conf_file in "$DOTFILES_CONF_D"/*.conf; do
	filename="$(basename "$conf_file")"
	target="${CONF_D}/${filename}"

	if [ -L "$target" ]; then
		info "${filename} already symlinked"
	else
		if [ -e "$target" ]; then
			warn "${filename} exists and is not a symlink, backing up"
			mv "$target" "${target}.backup"
		fi
		ln -s "$conf_file" "$target"
		success "Symlinked ${filename}"
	fi
done

# Start (or restart) PostgreSQL to pick up config changes
info "Starting PostgreSQL service"

if brew services start postgresql; then
	success "PostgreSQL service started"
else
	warn "PostgreSQL service may already be running, restarting"
	brew services restart postgresql
	success "PostgreSQL service restarted"
fi

# Since I always come here when psql is not working as expected
# here are some useful extra commands:
#
# brew services restart -v postgresql
# brew services info -a
# brew postgresql-upgrade-database
# tail /opt/homebrew/var/postgres/log/
#
# If the postmaster.pid exists when it shouldn't (e.g. forced reboot)
# its location will be /opt/homebrew/var/postgres/postmaster.pid
