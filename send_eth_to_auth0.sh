#!/bin/bash

echo Sending personal_sendTransaction command
curl \
    --data '{"jsonrpc":"2.0","method":"personal_sendTransaction","params":[{"from":"0x002227d6a35ed31076546159061bd5d3fefe9f0a","to":"0x00Bd138aBD70e2F00903268F3Db08f2D25677C9e","value":"0xdeadbeef0001"}, "user10"],"id":0}'\
    -H "Content-Type: application/json"\
    -X POST localhost:8541 &> /dev/null

echo Waiting 0.1 sec
sleep 0.1

echo Sending eth_getBalance command on node1
RESULT=$(curl --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x00Bd138aBD70e2F00903268F3Db08f2D25677C9e", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8540 -s)

echo Result is: $RESULT
