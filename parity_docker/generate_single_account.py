import sys
from pregenerate_validators_and_accounts import generate_account

def parse_args():
    usage = """ parses the arguments given in the CLI
    arguments are: ip user pwd"""
    args = sys.argv

    try:
        ip = str(args[1])
        user = str(args[2])
        pwd = str(args[3])
        return (ip, user, pwd)
    # will raise in case there is not enough args, and from the wrong type
    except:
        print(usage)
        raise ValueError

def main():
    """ uses the IP, the username and the password passed as arguments
    to create a new account on the parity node at IP"""
    try:
        ip, user, pwd = parse_args()
        generate_account(ip, user, pwd)
    except ValueError:
        pass

if __name__ == "__main__":
    main()
