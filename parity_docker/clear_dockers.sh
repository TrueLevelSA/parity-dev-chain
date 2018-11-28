#!/bin/bash

# stops parity, stops the containers, removes them
# removes docker_ips.txt
function clear_dockers {
    ./stop_dockers.sh

    docker-compose rm

    rm docker_ips.txt
}

clear_dockers
