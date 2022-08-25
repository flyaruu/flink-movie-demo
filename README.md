Container with a postgres 14 database containing the example dvd rental database.

http://www.postgresqltutorial.com/postgresql-sample-database/

Based on the debezium/postgres image, so it has change capture plugins installed.

I've refactored and split the database into three separate services

- film (including categories and actors)
- customer (including address, city, country)
- rental (payment, inventory store, etc.)

In order to split this I obviously had to remove some constraints:
inventory -> film_id
store -> address
staff -> address



Loosely based on:

https://github.com/ghusta/docker-postgres-world-db

Flink setup based on:

https://github.com/ververica/flink-sql-CDC
originally created by Marta Paes
