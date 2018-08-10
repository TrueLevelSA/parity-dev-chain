#!/bin/bash

# this function sends a SIGINT to all children processes
function cleanup_parity
{
    echo "Stopping parity."

    # sends a SIGINT to all the children processes from this
    # $$ returns curent PID
    pkill --signal SIGTERM -P $$

    echo "Waiting for parity instances to terminate."

    #waits for all children to terminate
    wait
}

# calls cleanup_parity when EXITting the shell
trap cleanup_parity EXIT
