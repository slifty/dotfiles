export EDITOR='code'

# set LIBRARY_PATH so it includes openssl if it exists
# (this is required by certain builds, e.g. python's psycopg2)
if [ -d /usr/local/opt/openssl/lib ] ; then
  export LIBRARY_PATH="${LIBRARY_PATH}:/usr/local/opt/openssl/lib"
fi
