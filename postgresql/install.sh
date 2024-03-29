echo "Starting postgresql service"
brew services start postgresql

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
