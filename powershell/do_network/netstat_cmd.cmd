# netstat
# netstat [-a] [-b] [-e] [-n] [-o] [-p <Protocol>] [-r] [-s] [<interval>] #CMD
netstat -s # Displays statistics by protocol. By default, statistics are shown for the TCP, UDP, ICMP, and IP protocols
netstat -s -p tcp > t10.txt # Get just TCP statistic pretty print
neststat -an