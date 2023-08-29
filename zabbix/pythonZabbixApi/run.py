import requests
import json
import logging


logging.basicConfig(filename="log.log", filemode="a",format="%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s", datefmt="%Y-%m-%d %H:%M:%S",level=logging.DEBUG)

class ApiWorker():

    def __init__(self):
        self.url = None
        self.user = None
        self.cred = None
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
            r = requests.post(self.url,
                              json={
                                  "jsonrpc": "2.0",
                                  "method": "user.login",
                                  "params": {
                                      "user": self.user,
                                      "password": self.cred},
                                  "id": 1
                              })

            # print(json.dumps(r.json(), indent=4, sort_keys=True))
            self.authtoken = r.json()["result"]
            logging.info("Authtoken acquired")
        except Exception as ex:
            logging.error(ex)
        return self.authtoken


if __name__ == "__main__":
    worker = ApiWorker()
    print(worker.cred)
