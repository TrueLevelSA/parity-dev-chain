#! /usr/bin/env python3

import sys
import json

def get_value_from_json_string(json_string, key):
    j = json.loads(json_string)
    return j[key]

def main():
    usage = """ get_json_content.py key
        key: the key to find in the json
        the json is found in stdin"""
    key = None
    try:
        key = sys.argv[1]
    except:
        print(usage)
        exit(1)
    value = get_value_from_json_string(sys.stdin.read(), key)

    print(value)

if __name__ == "__main__":
    main()
