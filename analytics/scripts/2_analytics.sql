
CREATE TABLE topscores (
    id integer PRIMARY KEY,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    score FLOAT
);

CREATE TABLE rental_anonymized (
	film_id integer,
	agebracket integer,
	rental_count integer
);

create table rental_by_age (
	agebracket BIGINT primary key,
	rental_count BIGINT
);

