#!/bin/bash

echo Sending personal_sendTransaction command
curl \
    --data '{"jsonrpc":"2.0","method":"personal_sendTransaction","params":[{"from":"0x007b9a37d838df0849689a47c7204aaea59dac62","to":"0x00Aa39d30F0D20FF03a22cCfc30B7EfbFca597C2","value":"0x1337"}, "user00"],"id":0}'\
    -H "Content-Type: application/json"\
    -X POST localhost:8540 &> /dev/null

echo Waiting 0.1 sec
sleep 0.1

echo Sending eth_getBalance command on node0
RESULT=$(curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x00Aa39d30F0D20FF03a22cCfc30B7EfbFca597C2", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8541 -s)

echo Result is: $RESULT
