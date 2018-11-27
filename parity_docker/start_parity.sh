#!/bin/bash

function start_parity {
    local -r NB_CONTAINERS=$(docker-compose ps -q parity | wc -l)

    for INDEX in $(seq 1 $NB_CONTAINERS)
    do
        docker-compose exec -d --index=${INDEX} parity parity --config node.toml --unsafe-expose
    done
}

start_parity
