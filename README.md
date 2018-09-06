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

- Run `init_nodes.sh`

This creates two nodes:
- `node0` composed of two accounts:
  - `0x00Bd138aBD70e2F00903268F3Db08f2D25677C9e`, an authority account
  - `0x004ec07d2329997267Ec62b4166639513386F32E`, a user account
- `node1` composed of one account: 
  - `0x00Aa39d30F0D20FF03a22cCfc30B7EfbFca597C2`, an authority account

## Run

- Run `run_nodes.sh`

## Send commands

- Run `send_eth_to_auth0.sh` in order to transfer `0xdeadbeef0001` wei from the user's account to the node0's authority account.
- Run `send_eth_to_auth1.sh` in order to transfer `0x1337` wei from the user's account to the node1's authority account.
