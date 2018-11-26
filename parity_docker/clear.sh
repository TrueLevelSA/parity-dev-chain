#!/bin/bash

function clear_docker {
    while read -r line || [[ -n "$line" ]]
    do
        local docker_id="$line"
        docker exec -d $docker_id touch /tmp/kill_container
    done < docker_ids.txt

    sleep 5

    while read -r line || [[ -n "$line" ]]
    do
        local docker_id="$line"
        echo "Stopping"
        docker stop $docker_id
        echo "Deleting"
        docker rm $docker_id
    done < docker_ids.txt

    rm docker_ids.txt
    rm docker_ips.txt
}

clear_docker
