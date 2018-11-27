#!/bin/bash

function generate_validators_and_accounts {

    local -r USER_PATTERN=user
    local -r USER_PWD_PATTERN=$USER_PATTERN

    local -r NODE_PATTERN=node
    local -r NODE_PWD_PATTERN=$NODE_PATTERN

    local I=1

    for DOCKER_ID in $(docker-compose ps -q parity)
    do
        local DOCKER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $DOCKER_ID)
        echo "Generating account for ${USER_PATTERN}$I ${USER_PWD_PATTERN}$I"
        python3 generate_single_account.py $DOCKER_IP ${USER_PATTERN}$I ${USER_PWD_PATTERN}$I
        echo "Generating account for ${NODE_PATTERN}$I ${NODE_PWD_PATTERN}$I"
        python3 generate_single_account.py $DOCKER_IP ${NODE_PATTERN}$I ${NODE_PWD_PATTERN}$I
        I=$((I+1))
    done
}

generate_validators_and_accounts

