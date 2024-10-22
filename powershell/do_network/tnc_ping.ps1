# 1  Ping devices locally or remotely
Test-NetConnection -ComputerName www.google.com
# ()
# PingSucceeded          : True
# PingReplyDetails (RTT) : 32 ms

# Test ping,  latency
# Ping tool is used to test whether a particular host is reachable across an IP network. 
# A Ping measures the time it takes for packets to be sent from the local host to a destination computer and back
ping www.google.com -t # CMD
# Pinging www.google.com [142.250.181.196] with 32 bytes of data:
# Reply from 142.250.181.196: bytes=32 time=34ms TTL=55
# Reply from 142.250.181.196: bytes=32 time=34ms TTL=55

# 2 Check connectivity based on port or service
Test-NetConnection -ComputerName xxx.xx.xxx.xx -Port 1000