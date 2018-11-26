#!/bin/bash

function get_docker_ip {
    rm docker_ips.txt
    while read -r line || [[ -n "$line"  ]]
    do
        local docker_id="$line"
        echo "Getting IP from $docker_id"
        local docker_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $docker_id)
        echo "IP is: $docker_ip"
        echo $docker_ip >> docker_ips.txt
    done < docker_ids.txt
}

get_docker_ip
