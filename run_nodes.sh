#!/bin/bash

set -e
set -u

# returns the enode of the parity running on localhost:{port}. port must be given as the first paramter
function get_enode
{
    local -r JSON=$(curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST localhost:$1 -s)

    local -r ENODE=$(echo $JSON | python ../get_json_content.py result)

    echo $ENODE
}

# connect_nodes node_0_enode node_1_port
function connect_node
{
    echo "Connecting localhost:$2 with $1"
    local -r DATA='{"jsonrpc":"2.0","method":"parity_addReservedPeer","params":["'$1'"],"id":0}'
    curl --data $DATA -H "Content-Type: application/json" -X POST localhost:$2 -s | \
        grep -q "true" \
        && echo "Done" \
        || echo "Not ok"
}

function run_nodes
{
    # cd to the script directory
    local -r PATH_TO_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source $PATH_TO_SCRIPT/tools/cleanup_parity.sh # this will cleanly kill all children processes
    pushd $PATH_TO_SCRIPT/config_run &> /dev/null # silently cd

    local -r PARITY_EXE_PATH=../parity-ethereum/target/debug/parity

    echo "Starting Parity in background."
    $PARITY_EXE_PATH --config node0.toml &
    ($PARITY_EXE_PATH --config node1.toml & ) # &> /dev/null
    ($PARITY_EXE_PATH --config node2.toml & ) # &> /dev/null
    ($PARITY_EXE_PATH --config node3.toml & ) # &> /dev/null

    echo "Waiting for parity to be started."
    # hopefully 10 sec is enough
    sleep 10

    local -r ENODE_0=$(get_enode 8540)
    local -r ENODE_1=$(get_enode 8541)
    local -r ENODE_2=$(get_enode 8542)
    local -r ENODE_3=$(get_enode 8543)

    # connect all nodes, ring style
    connect_node $ENODE_0 8541
    connect_node $ENODE_1 8542
    connect_node $ENODE_2 8543
    connect_node $ENODE_3 8540

    # get back to where the script was before the call to this function
    popd &> /dev/null

    echo "Hit ^C to quit."
    sleep 10000000
}


run_nodes
