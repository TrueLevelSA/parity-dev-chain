#!/bin/bash

function start_dockers {
    docker-compose up -d --scale parity="$1"
}

if [ $# != 1 ]
then
    echo "Usage: $0 number_of_containers
    example: $0 5"
    exit
else
    start_dockers $1
    exit
fi

