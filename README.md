## TO REPRODUCE

```
docker-compose build
docker-compose up
```

In a separate terminal, run ./connectpostgres.sh
Open console on localhost:8082

Check the topic 'film.public.film' which will only show bytes. Other will show correctly.

My theory that one of the data types is the culprit, check them in the schema registry.