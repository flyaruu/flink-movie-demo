        CREATE TABLE country (
            country_id BIGINT,
country STRING,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'customer.public.country',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE city (
            city_id BIGINT,
city STRING,
country_id BIGINT,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'customer.public.city',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE address (
            address_id BIGINT,
address STRING,
address2 STRING,
district STRING,
city_id BIGINT,
postal_code STRING,
phone STRING,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'customer.public.address',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE customer (
            customer_id BIGINT,
first_name STRING,
last_name STRING,
email STRING,
address_id BIGINT,
activebool BOOLEAN,
create_date DATE,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'customer.public.customer',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE film (
            film_id BIGINT,
title STRING,
description STRING,
language_id SMALLINT,
rental_duration SMALLINT,
length SMALLINT,
rating STRING,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'film.public.film',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE category (
            category_id SMALLINT,
name STRING,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'film.public.category',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE film_category (
            film_id SMALLINT,
category_id SMALLINT,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'film.public.film_category',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE `language` (
            language_id SMALLINT,
name STRING,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'film.public.language',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE actor (
            actor_id SMALLINT,
first_name STRING,
last_name STRING,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'film.public.actor',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE film_actor (
            actor_id SMALLINT,
film_id SMALLINT,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'film.public.film_actor',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE inventory (
            inventory_id SMALLINT,
film_id SMALLINT,
store_id SMALLINT,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'rental.public.inventory',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE payment (
            payment_id INT,
customer_id SMALLINT,
staff_id SMALLINT,
rental_id INT,
amount decimal(5,2),
payment_date BIGINT,
payment_date_time AS FROM_UNIXTIME(payment_date / 1000000),
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'rental.public.payment',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE rental (
            rental_id INT,
rental_date BIGINT,
inventory_id INT,
customer_id SMALLINT,
return_date BIGINT,
return_date_time AS FROM_UNIXTIME(return_date / 1000000),
staff_id SMALLINT,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'rental.public.rental',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE staff (
            staff_id INT,
first_name STRING,
last_name STRING,
address_id SMALLINT,
email STRING,
salary SMALLINT,
store_id SMALLINT,
active BOOLEAN,
username STRING,
password STRING,
picture BYTES,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'rental.public.staff',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );
        CREATE TABLE store (
            store_id INT,
manager_staff_id SMALLINT,
address_id SMALLINT,
            `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp'
            ,
    last_update BIGINT,
    last_update_time AS FROM_UNIXTIME(last_update / 1000000)
        ) WITH (
            'connector' = 'kafka',
            'topic' = 'rental.public.store',
            'format' = 'debezium-avro-confluent',
            'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
            'scan.startup.mode' = 'earliest-offset',
            'properties.bootstrap.servers' = 'redpanda:29092',
            'properties.group.id' = 'analytics'
        );

CREATE TABLE reviewers (
    _id STRING,
    personid bigint,
    reviews ARRAY<ROW<id STRING, summary STRING, movie_id INT, score FLOAT>>,
PRIMARY KEY (_id) NOT ENFORCED
)
    WITH (
        'connector' = 'mongodb-cdc',
        'hosts' = 'mongo1:27017',
        'database' = 'review_database',
        'collection' = 'reviewers'
);

CREATE VIEW reviews AS
    SELECT rv.personid,r.id,r.summary,r.movie_id,r.score FROM reviewers rv 
        CROSS JOIN UNNEST(rv.reviews) AS r(id,summary,movie_id,score);

CREATE VIEW avgscores AS select r.personid, avg(r.score) as average from reviews r GROUP BY r.personid;

select first_name, average FROM customer, avgscores WHERE customer_id = personid;

CREATE TABLE topscores (
  id BIGINT,
  first_name STRING,
  last_name STRING,
  score FLOAT,
  PRIMARY KEY (id) NOT ENFORCED
) WITH (
   'connector' = 'jdbc',
   'url' = 'jdbc:postgresql://analytics-postgres:5432/dvdrental',
   'username' = 'postgres',
   'password' = 'mysecretpassword',
   'table-name' = 'topscores'
);