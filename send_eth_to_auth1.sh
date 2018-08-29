#!/bin/bash

echo Sending personal_sendTransaction command
curl --data  '{"jsonrpc":"2.0","method":"personal_sendTransaction","params":[{"from":"0x004ec07d2329997267Ec62b4166639513386F32E","to":"0x00Aa39d30F0D20FF03a22cCfc30B7EfbFca597C2","value":"0x1337"}, "user"],"id":0}' -H "Content-Type: application/json" -X POST localhost:8540 &> /dev/null

echo Waiting 10 sec
sleep 10

echo Sending eth_getBalance command
RESULT=$(curl --data  '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x00Aa39d30F0D20FF03a22cCfc30B7EfbFca597C2", "latest"],"id":1}' -H "Content-Type: application/json" -X POST localhost:8541 -s)

echo Result is: $RESULT
