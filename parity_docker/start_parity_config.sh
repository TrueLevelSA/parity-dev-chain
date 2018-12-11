#!/bin/bash

# starts parity in all the nodes of the docker-compose "cluster"
function start_parity {
    for DOCKER_ID in $(docker-compose ps -q parity)
    do
        echo "Starting parity in $DOCKER_ID"
        docker exec -d $DOCKER_ID parity --config node-no-engine.toml --unsafe-expose
    done
}

start_parity
