if [ -d /usr/local/opt/mysql-client/bin ] ; then
	export PATH="/usr/local/opt/mysql-client/bin:$PATH"
fi

# M1 macs use a different path
if [ -d /opt/homebrew/opt/mysql-client/bin ] ; then
	export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
fi
