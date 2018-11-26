#! /bin/sh

# IF there is an error called "Invalid cross-device link" during build: execute next line
# echo N | sudo tee /sys/module/overlay/parameters/metacopy

docker build -t tl:parity ./docker
