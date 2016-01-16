#! /bin/sh
#
# Populate database schema for Bacula
#

# Stop on error
set -e

# Populate Bacula schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_bacula ]; then
  /usr/libexec/bacula/make_mysql_tables
  if [ ${?} -eq 0 ]; then
    echo "Bacula database schema created" > /etc/sysconfig/mysqldb_bacula
  else
    echo "Can not create Bacula schema"; exit 1
  fi
fi
