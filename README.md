# parity-dev-chain
Scripts to create and manage a parity dev chain

Based on [https://github.com/paritytech/wiki/blob/master/Demo-PoA-tutorial.md](https://github.com/paritytech/wiki/blob/master/Demo-PoA-tutorial.md)


## Requirements
- Rust's `cargo`
- `bash`
- `python`

## Custom Parity compiling
- `git submodule init`
- `git submodule update --remote`
- Run `build_parity.sh` (you might need your ssh-agent to be setup to pull from core-cbc)

## Init

- `echo node0 > config_run/node0.pwd`
- `echo node1 > config_run/node1.pwd`
- `echo node2 > config_run/node2.pwd`
- `echo node3 > config_run/node3.pwd`
- Run `init_nodes.sh`

This creates two nodes:
- `node0` composed of two accounts:
  - `0x00Bd138aBD70e2F00903268F3Db08f2D25677C9e`, an authority account
  - `0x007b9a37d838df0849689a47c7204aaea59dac62`, a user account
- `node1` composed of two accounts:
  - `0x00Aa39d30F0D20FF03a22cCfc30B7EfbFca597C2`, an authority account
  - `0x002227d6a35ed31076546159061bd5d3fefe9f0a`, a user account
- `node2` composed of two accounts:
  - `0x002e28950558fbede1a9675cb113f0bd20912019`, an authority account
  - `0x0067b732fee1d6cb0da1c64c0a7ee4a8633a6921`, a user account
- `node3` composed of two accounts:
  - `0x00a94ac799442fb13de8302026fd03068ba6a428`, an authority account
  - `0x00c72487a1ce367813de1757ebfc86c191d6f8c5`, a user account


## Run

- Run `run_nodes.sh`
  - One of the node's logs are colored, the other's not.
  - Log files are saved in `/tmp/parity[n].log`.

## Reset databases

If you wish to reset the nodes DB's, run `clear_db.sh`.
You'll have to re-run `init_nodes.sh`.

## Send commands

- Run `send_eth_to_auth0.sh` in order to transfer `0xdeadbeef0001` wei from the user's account to the node0's authority account.
- Run `send_eth_to_auth1.sh` in order to transfer `0x1337` wei from the user's account to the node1's authority account.

## Test

- Run `test_bc.sh`
  - Decrease `$SLEEPING_TIME` to increase the chance to have uncles.
