#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql --skip-networking &
pid="$!"

for i in $(seq 1 30); do
    if mariadb-admin -u root ping --silent; then
        break
    fi
    sleep 1
done

if ! mariadb-admin -u root ping --silent; then
    echo "MariaDB failed to start"
    exit 1
fi

bash /usr/local/bin/create_database.sh

mariadb-admin -u root shutdown
wait "$pid"

exec mysqld --user=mysql --bind-address=0.0.0.0
