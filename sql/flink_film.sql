CREATE TABLE country (
    country_id bigint,
    country STRING,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'customer.public.country',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE city (
    city_id bigint,
    city STRING,
    country_id bigint,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'customer.public.city',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE address (
    address_id bigint,
    address STRING,
    address2 STRING,
    district STRING,
    city_id bigint,
    postal_code STRING,
    phone STRING,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'customer.public.address',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE customer (
    customer_id bigint,
    first_name STRING,
    last_name STRING,
    email STRING,
    address_id bigint,
    activebool boolean,
    create_date date,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'customer.public.customer',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE film (
    film_id bigint,
    title STRING,
    description STRING,
    language_id smallint,
    rental_duration smallint,
    length smallint,
    rating STRING,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'film.public.film',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE category (
    category_id smallint,
    name STRING,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'film.public.category',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE film_category (
    film_id smallint,
    category_id smallint,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'film.public.film_category',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE `language` (
    language_id smallint,
    name STRING,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'film.public.language',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE actor (
    actor_id smallint,
    first_name STRING,
    last_name STRING,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'film.public.actor',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE film_actor (
    actor_id smallint,
    film_id smallint,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'film.public.film_actor',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE inventory (
    inventory_id smallint,
    film_id smallint,
    store_id smallint,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'rental.public.inventory',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE payment (
    payment_id int,
    customer_id smallint,
    staff_id smallint,
    rental_id int,
    amount decimal(5, 2),
    payment_date bigint,
    payment_date_time AS FROM_UNIXTIME (payment_date / 1000000),
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp'
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'rental.public.payment',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE rental (
    rental_id int,
    rental_date bigint,
    inventory_id int,
    customer_id smallint,
    return_date bigint,
    return_date_time AS FROM_UNIXTIME (return_date / 1000000),
    staff_id smallint,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'rental.public.rental',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE staff (
    staff_id int,
    first_name STRING,
    last_name STRING,
    address_id smallint,
    email STRING,
    salary smallint,
    store_id smallint,
    active boolean,
    username STRING,
    PASSWORD STRING,
    picture BYTES,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'rental.public.staff',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);

CREATE TABLE store (
    store_id int,
    manager_staff_id smallint,
    address_id smallint,
    `record_time` TIMESTAMP_LTZ (3) METADATA
FROM
    'timestamp',
    last_update bigint,
    last_update_time AS FROM_UNIXTIME (last_update / 1000000)
)
    WITH (
        'connector' = 'kafka',
        'topic' = 'rental.public.store',
        'format' = 'debezium-avro-confluent',
        'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
        'scan.startup.mode' = 'earliest-offset',
        'properties.bootstrap.servers' = 'redpanda:29092',
        'properties.group.id' = 'analytics'
);


select cu.customer_id, co.country from customer cu, address a, city c, country co where c.country_id = co.country_id AND a.city_id = c.city_id and cu.address_id = a.address_id;
