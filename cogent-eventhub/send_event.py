# Version: 1.1.0
# This script reads configuration from a JSON file and sends structured data to Azure Event Hub.

import asyncio
import json
import os
from datetime import datetime, timezone
from azure.eventhub import EventData, TransportType
from azure.eventhub.aio import EventHubProducerClient

def load_config(file_path="config.json"):
    # Load connection details from a local JSON file
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Configuration file {file_path} not found.")
    
    with open(file_path, "r") as f:
        return json.load(f)

async def run():
    # Load settings
    config = load_config()
    connection_str = config.get("connection_str")
    hub_name = config.get("hub_name")

    # Initialize client using config values
    producer = EventHubProducerClient.from_connection_string(
        conn_str=connection_str,
        eventhub_name=hub_name,
        transport_type=TransportType.AmqpOverWebsocket
    )
    
    async with producer:
        event_data_batch = await producer.create_batch()

        # Structured data payload
        tags = [
            {"tag": "tag1", "val": 45.2, "q": "Good"},
            {"tag": "tag2", "val": 12.8, "q": "Good"},
            {"tag": "tag3", "val": 0.0, "q": "Bad"}
        ]

        for item in tags:
            payload = {
                "tag": item["tag"],
                "timestamp": datetime.now(timezone.utc).isoformat(),
                "quality": item["q"],
                "value": item["val"]
            }
            event_data_batch.add(EventData(json.dumps(payload)))

        try:
            await producer.send_batch(event_data_batch)
            print(f"Successfully authenticated using config and sent events to {hub_name}.")
        except Exception as e:
            print(f"Failed to send events: {e}")

if __name__ == "__main__":
    asyncio.run(run())