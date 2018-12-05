#! /bin/bash

SLEEPING_TIME=1
for i in {1..250000}
do
    ./send_eth_to_auth1.sh
    sleep $SLEEPING_TIME
    ./send_eth_to_auth0.sh
    sleep $SLEEPING_TIME
    echo $i
done
