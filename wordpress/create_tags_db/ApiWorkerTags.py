import requests
import base64
import json
import logging


import requests
import json
import random

logging.basicConfig(filename="log.log", filemode="a", format="%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s",
                    datefmt="%Y-%m-%d %H:%M:%S", level=logging.DEBUG)


class ApiWorker():

    def __init__(self):
        self.user = None
        self.cred = None
        self.read_vault()

    def read_vault(self):
        try:
            with open("keyvault.json") as fi:
                data_tmp = json.load(fi)
                data = data_tmp["keyvault"]
                rv = data[0]
                self.user = rv["user"]
                self.cred = rv["cred"]
        except FileNotFoundError as ex:
            logging.info(ex)

    def created_db(self):
        sql_create_db =  '''create'''
        try:
           pass
        except Exception as ex:
            logging.error(ex)

    def insert_tags(self):
        sql_insert_tags =  '''create'''
        try:
            pass
        except Exception as ex:
            logging.error(ex)

    def get_tags(self):
        sql_get_tags =  '''create'''
        try:
            pass
        except Exception as ex:
            logging.error(ex)

    def update_tag(self):
        sql_update_tags =  '''create'''
        try:
            pass
        except Exception as ex:
            logging.error(ex)

    def delete_tag(self):
        sql_delete_tags =  '''create'''
        try:
            pass
        except Exception as ex:
            logging.error(ex)



if __name__ == "__main__":
    pass
   
