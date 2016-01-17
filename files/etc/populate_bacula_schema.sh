#! /bin/sh
#
# Populate database schema for Bacula
#

# Stop on error
set -e

# Set path
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin

# Set MySQL parameter
MYSQL_COMMAND=$(which mysql)
MYSQL_USER="root"
MYSQL_PASSWORD=${1:-0nly4install}

# Define schema
INPUT_FILE="/usr/libexec/bacula/make_mysql_tables"
TMP_FILE="/tmp/schema_mysql.sql"
SCHEMA_BACULA="/etc/bacula/schema_mysql.sql"

# Populate Bacula schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_bacula ]; then
  cat ${INPUT_FILE} | sed '1,/END-OF-DATA/d' > ${TMP_FILE}
  if [ ${?} -ne 0 ]; then
    echo "Can not create temporary Bacula schema"; exit 1
  fi
  cat ${TMP_FILE} | sed '/END-OF-DATA/,$d' > ${SCHEMA_BACULA}
  if [ ${?} -ne 0 ]; then
    echo "Can not create Bacula schema"; exit 1
  fi
  rm ${TMP_FILE}
  if [ ${?} -ne 0 ]; then
    echo "Can not remove temporary file"; exit 1
  fi
  sed -i 's/\\`/`/g' ${SCHEMA_BACULA}
  if [ ${?} -ne 0 ]; then
    echo "Can not remove unmask from SQL input"; exit 1
  fi
  ${MYSQL_COMMAND} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} bacula < ${SCHEMA_BACULA}
  if [ ${?} -eq 0 ]; then
    echo "Bacula database schema created" > /etc/sysconfig/mysqldb_bacula
  else
    echo "Can not deploy Bacula schema"; exit 1
  fi
fi
