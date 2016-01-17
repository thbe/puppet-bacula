#! /bin/sh
#
# Populate database schema for Bacula
#

# Stop on error
set -e

# Set path
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin

# Populate Bacula schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_bacula ]; then
  /usr/libexec/bacula/make_mysql_tables
  if [ ${?} -eq 0 ]; then
    echo "Bacula database schema created" > /etc/sysconfig/mysqldb_bacula
  else
    echo "Can not create Bacula schema"; exit 1
  fi
fi
