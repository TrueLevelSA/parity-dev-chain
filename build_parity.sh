#! /bin/bash

function build_parity
{
    local -r PATH_TO_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    pushd $PATH_TO_SCRIPT/parity-ethereum &> /dev/null
    cargo build
    popd &> /dev/null
}

build_parity
