#!/bin/sh
curl -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @film.json localhost:8083/connectors/
curl -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @customer.json localhost:8083/connectors/
curl -X POST -H "Accept:application/json" -H "Content-Type:application/json" -d @rental.json localhost:8083/connectors/
