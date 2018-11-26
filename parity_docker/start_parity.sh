#!/bin/bash

function start_parity {
    docker-compose exec -d parity parity --config node.toml --unsafe-expose
}

start_parity
