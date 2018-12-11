#!/bin/bash

# gets the IPs of all parity nodes in the docker-compose "cluster"
# writes them in ./docker_ips.txt (file is overwritten)
function get_docker_ip {
    rm -f docker_ips.txt

    for DOCKER_ID in $(docker-compose ps -q parity)
    do
        echo "Getting IP from $DOCKER_ID"
        local DOCKER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $DOCKER_ID)
        echo "IP is: $DOCKER_IP"
        echo $DOCKER_IP >> docker_ips.txt
    done
}

get_docker_ip
