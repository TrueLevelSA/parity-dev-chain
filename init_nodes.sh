#!/bin/bash

set -e
set -u

function create_new_accounts
{
    # cd to the script directory
    local -r PATH_TO_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source $PATH_TO_SCRIPT/tools/cleanup_parity.sh # this will cleanly kill all children processes
    pushd $PATH_TO_SCRIPT/config_init &> /dev/null # silently cd

    local -r PARITY_EXE_PATH=../parity-ethereum/target/debug/parity

    echo "Starting Parity in background."
    $PARITY_EXE_PATH --config node0.toml &
    $PARITY_EXE_PATH --config node1.toml &

    echo "Waiting for parity to be started."
    # hopefully 2 sec is enough
    sleep 2

    echo "Creating first authority address."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node0", "node0"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 -s | \
        grep -q '0x00bd138abd70e2f00903268f3db08f2d25677c9e' \
        && echo "Address is valid" \
        || echo "Address is not valid"

    echo "Creating first user address on first parity instance."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user", "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 -s | \
        grep -q '0x004ec07d2329997267ec62b4166639513386f32e' \
        && echo "Address is valid" \
        || echo "Address is not valid"


    echo "Creating first user address on second parity instance."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user", "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541 -s | \
        grep -q '0x004ec07d2329997267ec62b4166639513386f32e' \
        && echo "Address is valid" \
            || echo "Address is not valid"

    echo "Creating second authority address."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node1", "node1"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541 -s | \
        grep -q '0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2' \
        && echo "Address is valid" \
        || echo "Address is not valid"

    # get back to where the script was before the call to this function
    popd &> /dev/null
}

create_new_accounts
