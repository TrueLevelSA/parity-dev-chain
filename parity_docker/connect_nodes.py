#!/usr/bin/env python3
"""Connects multiple parity nodes with each others."""
import argparse
from requests import post
import re


RE_IP = r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"


def get_enode(ip):
    if re.match(RE_IP, ip) is None:
        print('{} is not an ip'.format(ip))
        return None

    url = "http://{}:8545".format(ip)
    data = {
        "jsonrpc": "2.0",
        "method": "parity_enode",
        "params": [],
        "id": 0
    }
    r = post(url, json=data)
    return r.json()["result"]


def connect_enode(node0, node1) -> bool:
    """Connect node1 to node0."""
    url = "http://{}:8545".format(node0[0])
    data = {
        "jsonrpc": "2.0",
        "method": "parity_addReservedPeer",
        "params": [node1[1]],
        "id": 0
    }
    r = post(url, json=data)
    return r.json()["result"]


def layout_ring(length):
    """Connect in a ring layout. 0-1, 1-2, 2-3, ..., n-0."""
    return [(i, (i+1) % length) for i in range(length)]


def layout_full(length):
    """Connect in a full layout. 0-1, 0-2, ..., 0-n, 1-2, 1-3, ..., n-n-1."""
    return [(i, j) for i in range(length) for j in range(i+1, length)]


layouts = {
    'ring': layout_ring,
    'full': layout_full
}


def main():
    parser = argparse.ArgumentParser(description='Connects parity nodes.')
    parser.add_argument('--layout', choices=layouts.keys(), required=True)
    parser.add_argument('filename',
                        help='text file with each node ip on different lines')
    args = parser.parse_args()

    enodes = []
    print('enodes: ')
    with open(args.filename, 'r') as f:
        for line in f.readlines():
            ip = line.strip()
            enode = get_enode(ip)
            if enode is not None:
                enodes.append((ip, enode))
                print("{}.\t{}\t{}".format(len(enodes) - 1, ip, enode[:12]))

    for enode_a, enode_b in layouts[args.layout](len(enodes)):
        if connect_enode(enodes[enode_a], enodes[enode_b]):
            print('connected: {} to {}'.format(enode_a, enode_b))
        else:
            print('failed   : {} to {}'.format(enode_a, enode_b))


if __name__ == "__main__":
    main()
