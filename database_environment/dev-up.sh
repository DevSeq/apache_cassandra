#!/usr/bin/env bash

# Setup IP, Subnet, and Gateway Variables
IP="172.21.0.3"
IPPG="172.21.0.10"
SUBNET="172.21.0.0/16"
GATEWAY="172.21.0.1"

# Name the network and containers.
NETWORKNAME="apache-cassandra-net"
CASSANDRANODE="cassandra-node"
POSTGRESQL="postie-db"
PASSWORD="short_password_for_this_thing"

echo "Creating Docker Network"
docker network create --subnet="$SUBNET" --gateway="$GATEWAY" --attachable=true $NETWORKNAME

echo "Listing Docker networks."
docker network ls

echo "Inspecting 'devtwitz'"
docker network inspect $NETWORKNAME

echo "Creating Apache Cassandra Node."
docker run --name $CASSANDRANODE --network $NETWORKNAME --ip="$IP" -e CASSANDRA_BROADCAST_ADDRESS="$IP" -it -d cassandra:3.11.4
docker inspect $CASSANDRANODE

echo "Starting PostgreSQL."
docker run --name $POSTGRESQL --network $NETWORKNAME --ip="$IPPG" -e POSTGRES_PASSWORD=$PASSWORD -d postgres:11.2
docker inspect $POSTGRESQL

sleep 5s

export PGHOST=$IPPG
export PGPORT=5432
export PGDATABASE=postgres
export PGUSER=postgres
export PGPASSWORD=$PASSWORD

echo "Setting up database on Postgres."
psql -U postgres -f postgres/inception.sql -h $IPPG

docker ps
