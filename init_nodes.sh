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
    $PARITY_EXE_PATH --config node2.toml &
    $PARITY_EXE_PATH --config node3.toml &

    echo "Waiting for parity to be started."
    # hopefully 2 sec is enough
    sleep 2

    # 1st auth/user
    echo "Creating 1st authority address."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node0", "node0"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 -s | \
        grep -q '0x00bd138abd70e2f00903268f3db08f2d25677c9e' \
        && echo "Address is valid" \
        || echo "Address is not valid"
    echo "Creating user address on 1st parity instance."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user00", "user00"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 -s | \
        grep -q '0x007b9a37d838df0849689a47c7204aaea59dac62' \
        && echo "Address is valid" \
        || echo "Address is not valid"

    # 2nd auth/user
    echo "Creating 2nd authority address."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node1", "node1"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541 -s | \
        grep -q '0x00aa39d30f0d20ff03a22ccfc30b7efbfca597c2' \
        && echo "Address is valid" \
        || echo "Address is not valid"
    echo "Creating user address on 2nd parity instance."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user10", "user10"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8541 -s | \
        grep -q '0x002227d6a35ed31076546159061bd5d3fefe9f0a' \
        && echo "Address is valid" \
            || echo "Address is not valid"

    # 3rd auth/user
    echo "Creating 3rd authority address."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node2", "node2"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8542 -s | \
        grep -q '0x002e28950558fbede1a9675cb113f0bd20912019' \
        && echo "Address is valid" \
        || echo "Address is not valid"
    echo "Creating user address on 3rd parity instance."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user20", "user20"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8542 -s | \
        grep -q '0x0067b732fee1d6cb0da1c64c0a7ee4a8633a6921' \
        && echo "Address is valid" \
        || echo "Address is not valid"

    # 4th auth/user
    echo "Creating 4th authority address."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["node3", "node3"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8543 -s | \
        grep -q '0x00a94ac799442fb13de8302026fd03068ba6a428' \
        && echo "Address is valid" \
        || echo "Address is not valid"
    echo "Creating user address on 4th parity instance."
    curl --data '{"jsonrpc":"2.0","method":"parity_newAccountFromPhrase","params":["user30", "user30"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8543 -s | \
        grep -q '0x00c72487a1ce367813de1757ebfc86c191d6f8c5' \
        && echo "Address is valid" \
            || echo "Address is not valid"

    # get back to where the script was before the call to this function
    popd &> /dev/null
}

create_new_accounts
