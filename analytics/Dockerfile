# Init Example Database World on PostgreSQL 14
FROM debezium/postgres:14-alpine

ENV POSTGRES_USER postgres
ENV POSTGRES_DB dvdrental 

ADD scripts/* /docker-entrypoint-initdb.d/
RUN chmod -R +r /docker-entrypoint-initdb.d/

COPY docker-healthcheck /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-healthcheck

HEALTHCHECK CMD ["docker-healthcheck"]
