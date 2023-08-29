import requests
import json
import logging

UNAME = None
PWORD = None
AUTHTOKEN = None

#


def read_vault():
    try:
        with open("keyvault.json") as fi:
            data_tmp = json.load(fi)
            data = data_tmp["keyvault"]
            print(data)
            print(type(data))
            print(len(data))
    except FileNotFoundError as ex:
        logging.info(ex)

def connect_zabbix(url_zabbix):
    logging.info("Connection to zabbix, get token")
    
    global UNAME
    global PWORD
    global AUTHTOKEN
    r = requests.post(url_zabbix,
                  json={
                      "jsonrpc": "2.0",
                      "method": "user.login",
                      "params": {
                          "user": UNAME,
                          "password": PWORD},
                      "id": 1
                  })

    # print(json.dumps(r.json(), indent=4, sort_keys=True))
    AUTHTOKEN = r.json()["result"]
    logging.info(AUTHTOKEN)
    return AUTHTOKEN

def main():
    read_vault()


if __name__ == "__main__":
    main()
   
