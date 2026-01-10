#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh

check_command brew

info "Starting PostgreSQL service"

if brew services start postgresql; then
	success "PostgreSQL service started"
else
	warn "PostgreSQL service may already be running"
fi

# Since I always come here when psql is not working as expected
# here are some useful extra commands:
#
# brew services restart -v postgresql
# brew services info -a
# brew postgresql-upgrade-database
# tail /opt/homebrew/var/log/postgres.log
#
# If the postmaster.pid exists when it shouldn't (e.g. forced reboot)
# its location will be /opt/homebrew/var/postgres/postmaster.pid
