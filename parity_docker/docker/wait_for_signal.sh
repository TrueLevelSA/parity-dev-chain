#! /bin/bash

function killall_parity {
    # defaults to SIGTERM, which is caught by parity to terminate gracefully
    killall parity
}

# runs until $FILE_NAME exists
function wait_for_signal {
    local -r FILE_NAME=/tmp/kill_container
    rm $FILE_NAME

    while [ ! -f $FILE_NAME ]
    do
        sleep 2
    done
}

# will call killall parity on exit
# not called at the end of the wait_for_signal function because
# this is pid 0 on a docker container and thus killall_parity
# will be called no matter what kills the container (hopefully)
trap killall_parity EXIT

wait_for_signal
