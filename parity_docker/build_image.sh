#! /bin/sh

# IF there is an error called "Invalid cross-device link" during build: execute next line
# echo N | sudo tee /sys/module/overlay/parameters/metacopy
../build_parity.sh
cp ../parity-ethereum/target/debug/parity ./docker/parity
docker build -t tl:parity ./docker
