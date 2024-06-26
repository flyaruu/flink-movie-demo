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

SELECT UNNEST(rv.reviews) from reviewers rv

CREATE VIEW reviews AS
    SELECT rv.personid,r.id,r.summary,r.movie_id,r.score FROM reviewers rv 
        CROSS JOIN UNNEST(rv.reviews) AS r(id,summary,movie_id,score);


    CREATE VIEW reviews AS
        SELECT rv.personid,r.id,r.summary,r.movie_id,r.score 
            FROM reviewers rv 
                CROSS JOIN UNNEST(rv.reviews) AS r(id,summary,movie_id,score);



CREATE VIEW avgscores AS select r.personid, avg(r.score) as average,count(r.id) as `count` from reviews r GROUP BY r.personid;


select customer_id, first_name, last_name, average FROM customer, (
    select r.personid, avg(r.score) as average from (SELECT rv.personid,r.id,r.summary,r.movie_id,r.score FROM reviewers rv 
        CROSS JOIN UNNEST(rv.reviews) AS r(id,summary,movie_id,score)) r GROUP BY r.personid
) WHERE customer_id = personid;




select customer_id, first_name, last_name, average FROM customer, avgscores WHERE customer_id = personid;


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


CREATE VIEW avgscores2 AS select r.personid, avg(r.score) as average from (SELECT rv.personid,r.id,r.summary,r.movie_id,r.score FROM reviewers rv 
        CROSS JOIN  (rv.reviews) AS r(id,summary,movie_id,score)) r GROUP BY r.personid;

select customer_id, first_name, last_name, average FROM customer, avgscores WHERE customer_id = personid;

 select MONTH(date_of_birth), YEAR(date_of_birth) from customer;

 select FLOOR(YEAR(date_of_birth)/10)*10 from customer;

SELECT r.rental_id rental_id, FLOOR(YEAR(c.date_of_birth)/10)*10 agebracket, r.inventory_id, i.film_id 
FROM rental r, customer c, inventory i
WHERE r.customer_id = c.customer_id
    AND r.inventory_id = i.inventory_id;


-- Create anonymized rental view
CREATE VIEW ANON_RENTAL AS SELECT r.rental_id rental_id, FLOOR(YEAR(c.date_of_birth)/10)*10 agebracket, r.inventory_id, i.film_id 
FROM rental r, customer c, inventory i
WHERE r.customer_id = c.customer_id
    AND r.inventory_id = i.inventory_id;

-- query
INSERT INTO rental_anonymized
SELECT count(rental_id) as rental_count, agebracket from ANON_RENTAL GROUP BY agebracket;

INSERT INTO rental_anonymized 
SELECT film_id, agebracket, count(rental_id) as rental_count from ANON_RENTAL GROUP BY agebracket,film_id;


CREATE TABLE rental_anonymized (
	film_id SMALLINT,
	agebracket BIGINT,
	rental_count BIGINT NOT NULL,
	PRIMARY KEY (film_id,agebracket)  NOT ENFORCED
) WITH (
    'connector' = 'jdbc',
    'url' = 'jdbc:postgresql://analytics-postgres:5432/dvdrental',
    'username' = 'postgres',
    'password' = 'mysecretpassword',
    'table-name' = 'rental_anonymized'
 );

 CREATE TABLE rental_by_age (
	agebracket BIGINT PRIMARY KEY,
	rental_count BIGINT NOT NULL
) WITH (
    'connector' = 'jdbc',
    'url' = 'jdbc:postgresql://analytics-postgres:5432/dvdrental',
    'username' = 'postgres',
    'password' = 'mysecretpassword',
    'table-name' = 'rental_by_age'
 );


#############
 INSERT INTO rental_by_age SELECT agebracket,count(rental_id) as rental_count from ANON_RENTAL GROUP BY agebracket;


Flink SQL> CREATE TABLE rental_anonymized (
>         film_id SMALLINT,
>         agebracket BIGINT,
>         rental_count BIGINT NOT NULL,
>         PRIMARY KEY (film_id,agebracket) NOT ENFORCED
> ) WITH (
>     'connector' = 'jdbc',
>     'url' = 'jdbc:postgresql://analytics-postgres:5432/dvdrental',
>     'username' = 'postgres',
>     'password' = 'mysecretpassword',
>     'table-name' = 'rental_anonymized'
>  );
[INFO] Execute statement succeed.

Flink SQL> INSERT INTO rental_anonymized SELECT film_id,count(rental_id) as rental_count, agebracket from ANON_RENTAL GROUP BY agebracket,film_id;

