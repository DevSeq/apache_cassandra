#!/usr/bin/env bash

NETWORKNAME="apache-cassandra-net"
CASSANDRANODE="cassandra-node"
POSTGRESQL="postie-db"

echo "Stopping and removing containers."
docker stop $CASSANDRANODE
docker stop $POSTGRESQL
docker rm $CASSANDRANODE
docker rm $POSTGRESQL

echo "Removing Docker dev network."
docker network rm $NETWORKNAME

echo "Listing Docker networks."
docker network ls