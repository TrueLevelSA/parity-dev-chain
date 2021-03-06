#!/bin/bash

# generates accounts on all the nodes in the docker-compose "cluster"
# one standard and one validator account
# the used patterns must match the ones in pregenerate_validators_and_accounts.sh
function generate_validators_and_accounts {
    local -r NUMBER_TO_GENERATE=$1

    local -r DOCKER_ID=$(docker run -d tl:parity)

    docker exec -d $DOCKER_ID parity --config node-no-engine.toml --unsafe-expose

    sleep 2
    local -r IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $DOCKER_ID)

    local -r USER_PATTERN=user
    local -r USER_PWD_PATTERN=$USER_PATTERN

    local -r NODE_PATTERN=node
    local -r NODE_PWD_PATTERN=$NODE_PATTERN

    python3 pregenerate_validators_and_accounts.py $NUMBER_TO_GENERATE $IP $USER_PATTERN $USER_PWD_PATTERN $NODE_PATTERN $NODE_PWD_PATTERN

    docker exec $DOCKER_ID touch /tmp/kill_container
    sleep 3
    docker stop $DOCKER_ID
    docker rm $DOCKER_ID
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
