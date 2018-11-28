#!/bin/bash

function generate_validators_and_accounts {
    local -r NUMBER_TO_GENERATE=$1

    ./start_dockers.sh 1
    ./start_parity.sh
    ./get_ips.sh

    local -r IP=$(cat docker_ips.txt)

    local -r USER_PATTERN=user
    local -r USER_PWD_PATTERN=$USER_PATTERN

    local -r NODE_PATTERN=node
    local -r NODE_PWD_PATTERN=$NODE_PATTERN

    python3 pregenerate_validators_and_accounts.py $NUMBER_TO_GENERATE $IP $USER_PATTERN $USER_PWD_PATTERN $NODE_PATTERN $NODE_PWD_PATTERN

    ./stop_dockers.sh
}

if [ $# != 1 ]
then
    echo "Usage: $0 number_of_containers
    example: $0 5"
    exit
else
    generate_validators_and_accounts $1
    exit
fi
