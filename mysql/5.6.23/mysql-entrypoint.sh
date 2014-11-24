#!/bin/bash
set -e

if [ ! -d '/var/lib/mysql/mysql' -a "${1%_safe}" = 'mysqld' ]; then
  if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    MYSQL_ROOT_PASSWORD="root"
    echo >&2
    echo >&2 'Password set for root: ${MYSQL_ROOT_PASSWORD}'
  fi

  mysql_install_db --user=mysql --datadir=/var/lib/mysql

  # These statements _must_ be on individual lines, and _must_ end with
  # semicolons (no line breaks or comments are permitted).
  # TODO proper SQL escaping on ALL the things D:
  TEMP_FILE='/tmp/mysql-first-time.sql'
  echo "DELETE FROM mysql.user ;" >> "$TEMP_FILE"
  echo "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;" >> "$TEMP_FILE"
  echo "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;" >> "$TEMP_FILE"
  echo "DROP DATABASE IF EXISTS test ;" >> "$TEMP_FILE"

  if [ "$CREATION_SCRIPT" ]; then
    echo >&2 'Appending creation script.'
    cat ${CREATION_SCRIPT} >> "$TEMP_FILE"
  fi

  if [ -z "$CREATION_SCRIPT" ]; then
    echo >&2 'Warning: -e CREATION_SCRIPT not informed, mysql with no database/tables'
  fi

  echo 'FLUSH PRIVILEGES ;' >> "$TEMP_FILE"

  set -- "$@" --init-file="$TEMP_FILE"
fi

chown -R mysql:mysql /var/lib/mysql
exec "$@"