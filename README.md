Container with a postgres 14 database containing the example dvd rental database.

http://www.postgresqltutorial.com/postgresql-sample-database/

Based on the debezium/postgres image, so it has change capture plugins installed.

Building:
docker build -t floodplain/dvdrental:1 .

Usage:

docker-compose up


Loosely based on:

https://github.com/ghusta/docker-postgres-world-db
