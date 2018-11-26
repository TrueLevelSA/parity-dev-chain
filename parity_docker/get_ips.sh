#!/bin/bash

function get_docker_ip {
    rm -f docker_ips.txt
    docker-compose ps -q | while read -r line || [[ -n "$line"  ]]
    do
        local docker_id="$line"
        echo "Getting IP from $docker_id"
        local docker_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $docker_id)
        echo "IP is: $docker_ip"
        echo $docker_ip >> docker_ips.txt
    done
}

get_docker_ip
