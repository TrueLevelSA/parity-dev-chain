


# Improvements/Thoughts

- As we could update the config files while the containers are running, 
  it could be better to set `parity` as entrypoint of the dockerfiles 
  instead of `wait_for_signal.sh`.
- `docker-compose exec <options> <service> <command>` only sends the 
  `command` to first container of the `service`, that's why there are 
  `for`s all over the place.
