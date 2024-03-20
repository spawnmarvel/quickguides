from paho.mqtt import client as mqtt_client
import time
import json
import random
import logging

logging.basicConfig(filename="log.log", filemode="a",format="%(asctime)s - %(thread)d - %(process)d - %(filename)s - %(lineno)d - %(funcName)20s() %(name)s - %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S",level=logging.INFO)


MQTTHOST = None 
MQTTUSER = None  
MQTTPASS = None
MQTTTOPIC = "myhome/livingroom/temperature/sensor1" 
# Generate a Client ID with the publish prefix.
ran = random.randint(0, 10000)
CLIENT_ID = "publish-" + str(ran)
logging.info("CLIENT_ID " + str(CLIENT_ID))


def read_vault():
        global MQTTHOST 
        global MQTTUSER
        global MQTTPASS
        try:
            with open("keyvault.json") as fi:
                data_tmp = json.load(fi)
                data = data_tmp["keyvault"]
                rv = data[0]
                MQTTHOST = rv["mqtthost"]
                MQTTUSER = rv["mqttuser"]
                MQTTPASS = rv["mqttpass"]
                rv = MQTTHOST + " ; " + MQTTUSER
                logging.info(rv)
        except FileNotFoundError as ex:
            logging.info(ex)


def connect_mqtt():
    read_vault()
    global CLIENT_ID
    global MQTTHOST
    global MQTTUSER
    global MQTTPASS
    logging.info("User "+ str(MQTTUSER))
    def on_connect(client, userdata, flags, rc, duck_preperties):
        logging.info("On_connect: Client: " + str(client))
        logging.info("On_connect: flags:" + str(flags) + ". rc: " +str(rc) )
        if rc == 0:
            logging.info("Connected to MQTT Broker!")
        else:
            logging.error("Failed to connect, return code " +str(rc))
            

    # https://stackoverflow.com/questions/77984857/paho-mqtt-unsupported-callback-api-version-error
    client = mqtt_client.Client(mqtt_client.CallbackAPIVersion.VERSION2, CLIENT_ID)
    client.username_pw_set(str(MQTTUSER), str(MQTTPASS))
    client.on_connect = on_connect
    client.connect("localhost", 1883)
    client.on_disconnect = on_disconnect
    return client

def on_disconnect(client, userdata, rc):
    FIRST_RECONNECT_DELAY = 1
    RECONNECT_RATE = 2
    MAX_RECONNECT_COUNT = 12
    MAX_RECONNECT_DELAY = 60
    logging.info("Disconnected with result code: %s", rc)
    reconnect_count, reconnect_delay = 0, FIRST_RECONNECT_DELAY
    while reconnect_count < MAX_RECONNECT_COUNT:
        logging.info("Reconnecting in %d seconds...", reconnect_delay)
        time.sleep(reconnect_delay)

        try:
            client.reconnect()
            logging.info("Reconnected successfully!")
            return
        except Exception as err:
            logging.error("%s. Reconnect failed. Retrying...", err)

        reconnect_delay *= RECONNECT_RATE
        reconnect_delay = min(reconnect_delay, MAX_RECONNECT_DELAY)
        reconnect_count += 1
    logging.info("Reconnect failed after %s attempts. Exiting...", reconnect_count)



def publish(client):
    msg_count = 1
    global MQTTTOPIC
    while True:
        time.sleep(1)
        msg = "Data msg: " + str(msg_count)
        result = client.publish(MQTTTOPIC, msg)
        # result: [0, 1]
        status = result[0]
        if status == 0:
            rv = "Sent " + msg + ". to topic " + str(MQTTTOPIC)
            logging.info(rv)
        else:
            rv = "Failed to send " + msg + ". to topic " + str(MQTTTOPIC)
            logging.error(rv)
        msg_count += 1
        logging.info("Sleep for 10")
        time.sleep(10)

def run():
    logging.info("#### Start ####")
    while True:
        client = connect_mqtt()
        for x in range(100):
            client.loop_start()
            publish(client)
            client.loop_stop()


if __name__ == '__main__':
    run()