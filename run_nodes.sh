#!/bin/bash

set -e
set -u

function get_enode0
{
    local -r JSON=$(curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 -s)

    # not that great but it's easy, readable, and it works so...
    local -r PYTHON_CODE=$(cat <<EOF
import sys, json
j = json.load(sys.stdin)
print(j['result'])
EOF
)

    local -r ENODE=$(echo $JSON | python -c"$PYTHON_CODE" )

    echo $ENODE
}

function run_nodes
{
    # cd to the script directory
    local -r PATH_TO_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source $PATH_TO_SCRIPT/cleanup_parity.sh # this will cleanly kill all children processes
    pushd $PATH_TO_SCRIPT/run_config &> /dev/null # silently cd

    local -r PARITY_EXE_PATH=../parity-ethereum/target/debug/parity

    echo "Starting Parity in background."
    $PARITY_EXE_PATH --config node0.toml &
    $PARITY_EXE_PATH --config node1.toml &

    echo "Waiting for parity to be started."
    # hopefully 10 sec is enough
    sleep 10

    local -r ENODE_0=$(get_enode0)

    echo "Connecting node1 to node0: $ENODE_0"
    local -r DATA='{"jsonrpc":"2.0","method":"parity_addReservedPeer","params":["'$ENODE_0'"],"id":0}'
    curl --data $DATA -H "Content-Type: application/json" -X POST localhost:8541 -s | \
        grep -q "true" \
        && echo "Done" \
        || echo "Not ok"

    # get back to where the script was before the call to this function
    popd &> /dev/null

    echo "Hit ^C to quit."
    sleep 10000000
}


run_nodes
