# Version: 1.2.4
# This script directly targets Partition 0 to instantly fetch live payloads.

import asyncio
import json
import os
from azure.eventhub.aio import EventHubConsumerClient
from azure.eventhub import TransportType

def load_config(file_path="config.json"):
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Configuration file {file_path} not found.")
    with open(file_path, "r") as f:
        return json.load(f)

async def on_event(partition_context, event):
    try:
        body_str = event.body_as_str(encoding='UTF-8')
        data = json.loads(body_str)
        
        tag = data.get("tag", "Unknown")
        timestamp = data.get("timestamp", "N/A")
        quality = data.get("quality", "N/A")
        value = data.get("value", "N/A")
        
        print(f"[{timestamp}] Part: {partition_context.partition_id} | Tag: {tag} | Value: {value} | Quality: {quality}")
        
    except Exception as e:
        print(f"Error parsing event: {e}")

async def main():
    config = load_config()
    consumer_group = "$Default"

    client = EventHubConsumerClient.from_connection_string(
        conn_str=config.get("connection_str"),
        consumer_group=consumer_group,
        eventhub_name=config.get("hub_name"),
        transport_type=TransportType.AmqpOverWebsocket
    )
    
    async with client:
        print("Connecting directly to Partition 0 from the START of the window...")
        try:
            # Specifying partition_id bypasses the background cluster-balancing mechanics
            await client.receive(
                on_event=on_event,
                partition_id="0",
                starting_position="-1"
            )
        except Exception as e:
            print(f"Receiver error: {e}")

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\nReader stopped by user.")