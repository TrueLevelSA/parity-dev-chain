#! /bin/bash

./build_image.sh
./pregenerate_validators_and_accounts.sh $1
./start_dockers.sh $1
./start_parity_config.sh
./generate_validators_and_accounts.sh
./update_parity_config.sh
./get_ips.sh
./connect_nodes.py --layout ring docker_ips.txt

