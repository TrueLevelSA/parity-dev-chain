#!/bin/bash

# updates config files on all the containers
# then restart parity (or starts it if not already started)
function update_parity_config {
    local -r FILENAME=demo-spec.json
    local -r CONTAINER_FILENAME=$FILENAME
    local INDEX=1
    for DOCKER_ID in $(docker-compose ps -q parity)
    do
        echo "Updating $FILENAME into $DOCKER_ID"
        cat $FILENAME | docker exec -i $DOCKER_ID tee $CONTAINER_FILENAME > /dev/null

        docker exec -d $DOCKER_ID pkill parity
        NODE_VAL=node$INDEX
        docker exec $DOCKER_ID sh -c "echo $NODE_VAL > /run/node.pwd"

        local ADDRESS=$(sed "${INDEX}q;d" addresses.txt)
        echo "address is $ADDRESS"
        docker exec $DOCKER_ID sh -c "sed -i s/0x00Bd138aBD70e2F00903268F3Db08f2D25677C9e/$ADDRESS/ /run/node.toml"
        INDEX=$((INDEX+1))


    done

    sleep 5

    ./start_parity.sh
}

update_parity_config
