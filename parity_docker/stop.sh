#!/bin/bash

function get_docker_ip {
    rm docker_ips.txt
    while read -r line || [[ -n "$line"  ]]
    do
        local docker_id="$line"
        docker exec -d $docker_id touch /tmp/kill_container
    done < docker_ids.txt

    sleep 5

    while read -r line || [[ -n "$line"  ]]
    do
        local docker_id="$line"
        docker stop $docker_id
    done < docker_ids.txt
}

get_docker_ip
