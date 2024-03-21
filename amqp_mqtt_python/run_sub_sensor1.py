from paho.mqtt import client as mqtt_client
import time


# https://pypi.org/project/paho-mqtt/#client
# SUBSCRIBER EXAMPLE

import ssl
import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    print("Connected with result code: " + str(rc))
    client.subscribe('myhome/livingroom/temperature/sensor1')

def on_subscribe(client, userdata, mid, qos):
    print("Subscribed with qos: " + str(qos))

def on_message(client, userdata, message):
    print(message)

# client = mqtt.Client()
client = mqtt_client.Client(mqtt_client.CallbackAPIVersion.VERSION2)
client.on_connect = on_connect
client.on_subscribe = on_subscribe
client.on_message = on_message
client.username_pw_set("mhrnurnurhn", "brjnr")
client.connect("localhost", 8883, 60)

client.user_data_set([])
client.loop_forever()
print(str(client.user_data_get()))