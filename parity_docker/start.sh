#!/bin/bash

function start_docker {
    local -r DOCKER_ID=$(docker run -d tl:parity)
    echo $DOCKER_ID >> docker_ids.txt
}

start_docker
