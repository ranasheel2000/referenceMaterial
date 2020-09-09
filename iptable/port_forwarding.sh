#!/bin/bash

### PORT FORWARDING (DNAT) ###

# Port Forwarding is always done on the PREROUTING chain 

# flushing nat filter of PREROUTING chain
iptables -t nat -F  PREROUTING


# all the packets coming to the public IP address of the router and port 80 
# will be port forwarded to 192.168.0.20 and port 80
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.0.20


## VARIANTS


# 1.redirect port 8080 to port 80 
# Internet clients connect to the public IP address of the router and port 8080 and the packets are 
# redirected to the private server with 192.168.0.20 and port 80
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.20:80



#2. Load-Balancing
# On all 5 private servers (192.168.0.20-192.168.0.24)run the same service (e.g. HTTPS)
# The router will pick-up a random private IP from the range and then translate and send (port-forward) the packet to that IP
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.20-192.168.0.24

