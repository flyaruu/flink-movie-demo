CREATE CATALOG film WITH (
    'type'='jdbc',
    'property-version'='1',
    'base-url'='jdbc:postgresql://film:5432/',
    'default-database'='dvdrental',
    'username'='postgres',
    'password'='mysecretpassword'
);

CREATE CATALOG customer WITH (
    'type'='jdbc',
    'property-version'='1',
    'base-url'='jdbc:postgresql://customer:5432/',
    'default-database'='dvdrental',
    'username'='postgres',
    'password'='mysecretpassword'
);

CREATE TABLE customer_country (
    country_id BIGINT,
    country STRING,
    last_update BIGINT,
    `record_time` TIMESTAMP_LTZ(3) METADATA FROM 'timestamp',
    aap AS FROM_UNIXTIME(last_update / 1000000)
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer.public.country',
    'format' = 'debezium-avro-confluent',
    'debezium-avro-confluent.schema-registry.url' = 'http://redpanda:8081',
    'scan.startup.mode' = 'earliest-offset',
    'properties.bootstrap.servers' = 'redpanda:29092',
    'properties.group.id' = 'analytics'
)


CREATE TABLE customer_country(
    country_id BIGINT,
    country STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer.public.country',
    'format' = 'avro-confluent',
    'scan.startup.mode' = 'earliest-offset',
    'properties.bootstrap.servers' = 'redpanda:29092',
    'properties.group.id' = 'analytics'
);


CREATE TABLE customer_country(
    country_id BIGINT,
    country STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer.public.country',
    'format' = 'debezium-json',
    'scan.startup.mode' = 'earliest-offset',
    'properties.bootstrap.servers' = 'redpanda:29092',
    'properties.group.id' = 'analytics',
    'debezium-json.ignore-parse-errors' = 'true'
);


CREATE TABLE customer_country WITH (
    'connector' = 'kafka',
    'topic' = 'customer.public.country',
    'format' = 'debezium-json',
    'scan.startup.mode' = 'earliest-offset',
    'properties.bootstrap.servers' = 'redpanda:29092',
    'properties.group.id' = 'analytics',
    'debezium-json.schema-include' = 'false' 
) LIKE customer.dvdrental.`public.country` ( 
EXCLUDING OPTIONS);

,


select cu.customer_id, co.country from customer cu, address a, city c, country co where c.country_id = co.country_id AND a.city_id = c.city_id and cu.address_id = a.address_id;


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

select id, first_name, last_name, average FROM customer, avgscores WHERE customer_id = personid;

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