#!/bin/sh
curl -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @debezium_avro/film.json localhost:8083/connectors/
