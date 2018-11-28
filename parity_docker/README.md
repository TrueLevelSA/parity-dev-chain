# Scripts

## `build_image.sh`
- Builds the docker image
  - Pulls the last commit on the TrueLevel's parity github fork, on the `feature/instant_seal_consensus` branch
  - Compiles parity
  - Puts the configuration files on the image

## `clear_dockers.sh`
- Clears the running docker containers
  - Cleanly stops the containers (and gracefully terminates parity)
  - Removes the containers
  - Cleans up `docker_ips.txt`

## `connect_nodes.py`
- Connects the parity nodes between themselves according to some layout
  The nodes don't use the standard discovery so we can have a constant layout
  - Layout if for now a simple ring or fully connected

## `generate_validators_and_accounts.sh`
- Generates two account per parity node: a standard one and a validator one

## `get_ips.sh`
- Gets the IP addresses of all running nodes
  - Writes them in the `docker_ips.txt` file

## `pregenerates_validators_and_accounts.sh`
- Creates a single container with parity and generates `N` accounts on it
  puts these accounts in the `demo-spec.json` configuration file (half as validators)
  - Creates a container
  - Starts parity
  - Creates 2`N` accounts (`N` validators, `N` standard accounts)
  - Puts the accounts in the config file
  - Kills parity 
  - Removes the container

## `start_dockers.sh`
- Starts `N` docker containers with parity (parity is not started)

## `stop_docker.sh`
- Cleanly kills parity, and the containers.

## `upgrade_parity_config.sh`
- Sends the `demo-spec.json` file to all the containers, and restarts parity

Probably could do that at container build time now that I'm thinking about it

# Improvements/Thoughts

- As we could update the config files while the containers are running, 
  it could be better to set `parity` as entrypoint of the dockerfiles 
  instead of `wait_for_signal.sh`.
- `docker-compose exec <options> <service> <command>` only sends the 
  `command` to first container of the `service`, that's why there are 
  `for`s all over the place.
