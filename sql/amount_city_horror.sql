CREATE VIEW CUSTOMER_CITY AS select c.customer_id, ci.city, ct.country from customer c,address a, city ci, country ct WHERE c.address_id = a.address_id AND a.city_id = ci.city_id AND ci.country_id = ct.country_id;
CREATE VIEW TOTALPAY AS SELECT p.amount, p.rental_id, i.inventory_id, i.film_id, r.customer_id FROM payment p, rental r, inventory i WHERE p.rental_id = r.rental_id AND r.inventory_id = i.inventory_id;

select SUM(amount) as amount, city, country from TOTALPAY t, CUSTOMER_CITY cc, film_category fc WHERE t.customer_id = cc.customer_id AND fc.film_id = t.film_id AND fc.category_id = 11 GROUP BY city,country;


CREATE CATALOG analytics WITH (
  'type' = 'jdbc',
  'default-database' = 'dvdrental',
  'username' = 'postgres',
  'password' = 'mysecretpassword',
  'base-url' = 'jdbc:postgresql://analytics-postgres:5432/'
)

CREATE TABLE amount_horror (
	amount decimal not NULL,
	city VARCHAR,
	country VARCHAR,
	primary key (city,country) NOT ENFORCED
) WITH (
   'connector' = 'jdbc',
   'url' = 'jdbc:postgresql://analytics-postgres:5432/dvdrental',
   'username' = 'postgres',
   'password' = 'mysecretpassword',
   'table-name' = 'amount_horror'
);

