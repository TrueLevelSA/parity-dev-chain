#!/bin/bash

function start_parity {
    for DOCKER_ID in $(docker-compose ps -q parity)
    do
        echo "Starting parity in $DOCKER_ID"
        docker exec -d $DOCKER_ID parity --config node.toml --unsafe-expose
    done
}

start_parity
