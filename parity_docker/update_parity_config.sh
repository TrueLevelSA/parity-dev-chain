#!/bin/bash

function update_parity_config {
    local -r FILENAME=demo-spec.json
    local -r CONTAINER_FILENAME=$FILENAME
    for DOCKER_ID in $(docker-compose ps -q parity)
    do
        echo "Updating $FILENAME into $DOCKER_ID"

        cat $FILENAME docker exec -i tee $CONTAINER_FILENAME > /dev/null

    done
}

update_parity_config
