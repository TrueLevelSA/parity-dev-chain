#!/bin/bash

function stop_dockers {
    docker-compose exec -d parity touch /tmp/kill_container
    sleep 10
    docker-compose stop
}

stop_dockers
