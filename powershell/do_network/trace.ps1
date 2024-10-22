# 3. Trace route communications
# Traceroute ensures each hop on the way to a destination device drops a packet and sends back an ICMP error message. 
# This means traceroute can measure the duration of time between when the data is sent and when the ICMP message is received back for each hop—giving you the RTT value for each hop
tracert www.goggle.com # CMD
# Tracing route to www.goggle.com [45.55.44.56]
# over a maximum of 30 hops:
# 1    <1 ms    <1 ms    <1 ms  xx.xx.x.x.x
# 2     3 ms     1 ms     1 ms  somedomain.no [x.x.x.x..x]

Test-NetConnection www.google.com -TraceRoute