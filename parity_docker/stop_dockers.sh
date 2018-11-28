#!/bin/bash

# stops parity, then stops the containers
function stop_dockers {
    for DOCKER_ID in $(docker-compose ps -q parity)
    do
        echo "Sending stop signal to $DOCKER_ID"
        docker exec $DOCKER_ID touch /tmp/kill_container
    done

    # containers have a sleep time of 2 secs
    sleep 3
    docker-compose stop
}

stop_dockers
