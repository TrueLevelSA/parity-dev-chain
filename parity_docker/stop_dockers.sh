#!/bin/bash

function stop_dockers {
    local -r NB_CONTAINERS=$(docker-compose ps -q parity | wc -l)
    for INDEX in $(seq 1 $NB_CONTAINERS)
    do
        docker-compose exec  --index=${INDEX} parity touch /tmp/kill_container
    done

    # containers have a sleep time of 2 secs
    sleep 3
    docker-compose stop
}

stop_dockers
