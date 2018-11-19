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
- Run `build_parity.sh`

## Init

- `echo CHOSE_A_PASSWORD > config_run/node0.pwd`
- `echo CHOSE_A_PASSWORD > config_run/node1.pwd`
- Run `init_nodes.sh`

This creates two nodes:
- `node0` composed of two accounts:
  - `0x00Bd138aBD70e2F00903268F3Db08f2D25677C9e`, an authority account
  - `0x007b9a37d838df0849689a47c7204aaea59dac62`, a user account
- `node1` composed of two accounts: 
  - `0x00Aa39d30F0D20FF03a22cCfc30B7EfbFca597C2`, an authority account
  - `0x002227d6a35ed31076546159061bd5d3fefe9f0a`, a user account

## Run

- Run `run_nodes.sh`

## Send commands

- Run `send_eth_to_auth0.sh` in order to transfer `0xdeadbeef0001` wei from the user's account to the node0's authority account.
- Run `send_eth_to_auth1.sh` in order to transfer `0x1337` wei from the user's account to the node1's authority account.
