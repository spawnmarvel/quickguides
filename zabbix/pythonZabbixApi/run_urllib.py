import urllib.request
import json
import logging

logging.basicConfig(filename="log.log", filemode="a",format="%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s", datefmt="%Y-%m-%d %H:%M:%S",level=logging.DEBUG)

# https://www.zabbix.com/documentation/current/en/manual/api
# The Zabbix API is an HTTP-based API, and it is shipped as a part of the web frontend. It uses the JSON-RPC 2.0 protocol, which means two things:
# The API consists of a set of separate methods.
# Requests and responses between the clients and the API are encoded using the JSON format.

class ApiWorker():

    def __init__(self):
        self.url = None
        self.user = None
        self.cred = None
        self.port = None
        self.authtoken = None
        self.read_vault()
        self.connect_zabbix()

    def read_vault(self):
        try:
            with open("keyvault.json") as fi:
                data_tmp = json.load(fi)
                data = data_tmp["keyvault"]
                rv = data[0]
                self.url = rv["url"]
                self.user = rv["user"]
                self.cred = rv["cred"]
        except FileNotFoundError as ex:
            logging.info(ex)

    def connect_zabbix(self):
        logging.info("Connection to zabbix, trying to get token")
        try:
            logging.info(self.url)
           
            # headers
            headers = {'Content-type': 'application/json'}
            # post data
            post_data = {"jsonrpc": "2.0", "method": "user.login","params": {
                                      "user": self.user,
                                      "password": self.cred},
                                  "id": 1
            }
            post_json = json.dumps(post_data).encode("utf-8")
            req = urllib.request.Request(self.url, post_json, headers)
            with urllib.request.urlopen(req) as f:
                result = f.read()
                rv = result.decode()
                logging.debug(rv)
                json_object = json.loads(rv)
                # {"jsonrpc":"2.0","result":"TOKEN-TOKEN-TOKEN","id":1}
                self.authtoken = json_object["result"]
                logging.info("Authtoken acquired")

        except Exception as ex:
            logging.error(ex)
        return self.authtoken

if __name__ == "__main__":
    logging.info("Started")
    worker = ApiWorker()