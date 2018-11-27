import sys
import json
from requests import post

class Config:
    _RPC_PORT = "8545"
    _CONFIG_FILE_TEMPLATE = "demo-spec-template.json"
    _CONFIG_FILE_OUTPUT = "demo-spec.json"
    _REPLACE_VALIDATORS_TEXT = "REPLACE_VALIDATORS"
    _REPLACE_ACCOUNTS_TEXT = "REPLACE_ACCOUNTS"

def parse_args():
    usage = """ parses the arguments given in the CLI
    arguments are: number_accounts ip user_pattern user_pwd_pattern node_pattern node_pwd_pattern """
    args = sys.argv

    try:
        number_accounts = int(args[1])
        ip = str(args[2])
        user_pattern = str(args[3])
        user_pwd_pattern = str(args[4])
        node_pattern = str(args[5])
        node_pwd_pattern = str(args[6])
        return (number_accounts, ip, user_pattern, user_pwd_pattern, node_pattern, node_pwd_pattern)
    # will raise in case there is not enough args, and from the wrong type
    except:
        print(usage)
        raise ValueError

def generate_account(ip, user, pwd):
    """ creates an account on the parity node using the credentials
    returns the address of the account in str format"""

    data = {
            "jsonrpc": "2.0",
            "method": "parity_newAccountFromPhrase",
            "params": [user, pwd],
            "id": 0
        }

    url = "http://"+ip+":8545"
    r = post(url, json=data)
    address = r.json()["result"]
    print("Created account {} with pwd {}: {}".format(user, pwd, address))
    return address

def generate_all(number_accounts, ip, user_pattern, user_pwd_pattern, node_pattern, node_pwd_pattern):
    """ generates accounts for both users and nodes
    returns a tuple (list_users, list_nodes), each containing a list of addresses"""

    list_users = []
    list_nodes = []
    for i in range(number_accounts):
        index = str(i+1)
        list_users.append(generate_account(ip, user_pattern+index, user_pwd_pattern+index))
        list_nodes.append(generate_account(ip, node_pattern+index, node_pwd_pattern+index))

    return list_users, list_nodes

def save(list_users, list_nodes):
    data = None
    with open(Config._CONFIG_FILE_TEMPLATE, 'r') as f:
        data = f.read()

    validator_text = ""
    for validator in list_nodes:
        validator_text += '{ "address": "%s", "weight": 1},\n' % validator

    # trim last comma
    validator_text = validator_text[:-2]

    account_text = ""
    for account in list_users:
        account_text += '"%s": { "balance": "10000000000000000000000"},\n' % account

    for account in list_nodes:
        account_text += '"%s": { "balance": "10000000000000000000000"},\n' % account

    # trim last comma
    account_text = account_text[:-2]

    data = data.replace(Config._REPLACE_ACCOUNTS_TEXT, account_text)
    data = data.replace(Config._REPLACE_VALIDATORS_TEXT, validator_text)

    with open(Config._CONFIG_FILE_OUTPUT, 'w+') as f:
        f.write(json.dumps(json.loads(data), indent=4))

def generate_and_save(number_accounts, ip, user_pattern, user_pwd_pattern, node_pattern, node_pwd_pattern):
    list_users, list_nodes = generate_all(number_accounts, ip, user_pattern, user_pwd_pattern, node_pattern, node_pwd_pattern)
    save(list_users, list_nodes)

def main():
    try:
        number_accounts, ip, user_pattern, user_pwd_pattern, node_pattern, node_pwd_pattern = parse_args()
    except ValueError:
        pass
    generate_and_save(number_accounts, ip, user_pattern, user_pwd_pattern, node_pattern, node_pwd_pattern)

if __name__ == "__main__":
    main()
