# Version: 1.1.2
# This script sends continuous updates every 5 seconds to verify live movement in Cogent.

import asyncio
import json
import random
from datetime import datetime, timezone
from azure.eventhub import EventData, TransportType
from azure.eventhub.aio import EventHubProducerClient

def load_config(file_path="config.json"):
    with open(file_path, "r") as f:
        return json.load(f)

async def send_data_loop():
    config = load_config()
    producer = EventHubProducerClient.from_connection_string(
        conn_str=config.get("connection_str"),
        eventhub_name=config.get("hub_name"),
        transport_type=TransportType.AmqpOverWebsocket
    )
    
    async with producer:
        print("Starting live stream... Press Ctrl+C to stop.")
        while True:
            event_data_batch = await producer.create_batch()

            # Create data with varying values
            tags = [
                {"tag": "tag1", "val": round(random.uniform(40, 50), 2), "q": "Good"},
                {"tag": "tag2", "val": round(random.uniform(10, 20), 2), "q": "Good"},
                {"tag": "tag3", "val": round(random.uniform(0, 5), 2), "q": "Good"}
            ]

            for item in tags:
                payload = {
                    "tag": item["tag"],
                    "timestamp": datetime.now(timezone.utc).isoformat(),
                    "quality": item["q"],
                    "value": item["val"]
                }
                event_data_batch.add(EventData(json.dumps(payload)))

            await producer.send_batch(event_data_batch)
            print(f"Sent batch at: {datetime.now().strftime('%H:%M:%S')}")
            
            # Wait 5 seconds before the next update
            await asyncio.sleep(5)

if __name__ == "__main__":
    try:
        asyncio.run(send_data_loop())
    except KeyboardInterrupt:
        print("\nStream stopped by user.")