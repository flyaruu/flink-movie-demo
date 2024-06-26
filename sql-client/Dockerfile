###############################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################


###############################################################################
#SQL CLI - inspired by https://github.com/wuchong/flink-sql-demo/tree/v1.11-EN/sql-client
###############################################################################

#FROM localflink
FROM flink:1.18.0

RUN wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.1.0-1.18/flink-sql-connector-kafka-3.1.0-1.18.jar
RUN wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-avro/1.18.0/flink-avro-1.18.0.jar
RUN wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-connector-jdbc/3.1.2-1.18/flink-connector-jdbc-3.1.2-1.18.jar
RUN wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/org/apache/flink/flink-avro-confluent-registry/1.18.0/flink-avro-confluent-registry-1.18.0.jar
RUN wget -P /opt/flink/lib/ https://github.com/knaufk/flink-faker/releases/download/v0.4.0/flink-faker-0.4.0.jar
RUN wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/avro/avro/1.10.0/avro-1.10.0.jar
RUN wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.12.5/jackson-core-2.12.5.jar
RUN wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.12.5/jackson-databind-2.12.5.jar
RUN wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.12.5/jackson-annotations-2.12.5.jar
RUN wget -P /opt/flink/lib/ https://maven.repository.redhat.com/earlyaccess/all/io/confluent/kafka-schema-registry-client/5.3.0/kafka-schema-registry-client-5.3.0.jar
RUN wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/2.8.1/kafka-clients-2.8.1.jar
RUN wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mongodb-cdc/3.0.1/flink-sql-connector-mongodb-cdc-3.0.1.jar
RUN wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/org/postgresql/postgresql/42.4.2/postgresql-42.4.2.jar

# Create CLI lib folder
COPY bin/* /opt/sql-client/
COPY sql/* /opt/sql/
RUN mkdir -p /opt/sql-client/lib

# Download connector libraries

# RUN wget -P /opt/sql-client/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka_2.12/1.19.0/flink-sql-connector-kafka_2.12-1.19.0.jar; \
#     wget -P /opt/sql-client/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-connector-kafka/1.19.0/flink-connector-kafka-1.19.0.jar; \
#     wget -P /opt/sql-client/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-connector-jdbc_2.12/1.19.0/flink-connector-jdbc_2.12-1.19.0.jar; \
#     wget -P /opt/sql-client/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-avro/1.19.0/flink-avro-1.19.0.jar; \
#     wget -P /opt/sql-client/lib/ https://repo1.maven.org/maven2/org/apache/flink/flink-avro-confluent-registry/1.19.0/flink-avro-confluent-registry-1.19.0.jar; \
#     wget -P /opt/sql-client/lib/ https://jdbc.postgresql.org/download/postgresql-42.3.3.jar; \
#     wget -P /opt/sql-client/lib/ https://github.com/knaufk/flink-faker/releases/download/v0.4.1/flink-faker-0.4.1.jar; \
#     wget -P /opt/sql-client/lib/ https://repo.maven.apache.org/maven2/org/apache/avro/avro/1.11.0/avro-1.11.0.jar; \
#     wget -P /opt/sql-client/lib/ https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.12.5/jackson-core-2.12.5.jar; \
#     wget -P /opt/sql-client/lib/ https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.12.5/jackson-databind-2.12.5.jar; \
#     wget -P /opt/sql-client/lib/ https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.12.5/jackson-annotations-2.12.5.jar; \
#     wget -P /opt/sql-client/lib/ https://maven.repository.redhat.com/earlyaccess/all/io/confluent/kafka-schema-registry-client/5.3.0/kafka-schema-registry-client-5.3.0.jar; \
#     wget -P /opt/sql-client/lib/ https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/2.8.1/kafka-clients-2.8.1.jar; \ 
#     wget -P /opt/sql-client/lib/ https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mongodb-cdc/2.2.0/flink-sql-connector-mongodb-cdc-2.2.0.jar

# Copy configuration
COPY conf/* /opt/flink/conf/

WORKDIR /opt/sql-client
ENV SQL_CLIENT_HOME /opt/sql-client

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
