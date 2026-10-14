FROM debian:bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/create_database.sh /usr/local/bin/create_database.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/create_database.sh \
    /usr/local/bin/entrypoint.sh \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
