#!/bin/bash

function clear_dockers {
    ./stop_dockers.sh

    docker-compose rm

    rm docker_ips.txt
}

clear_dockers
