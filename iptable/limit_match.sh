#!/bin/bash

iptables -F INPUT

# allow only 1 incoming ping (echo-request) per second with a burst of 3
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/sec --limit-burst 3 -j ACCEPT
# drop packets that were not accepted by the rule above (they are above the limit)
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP


# allow only 5 new incoming connections per second to port 443 (https) 
iptables -A INPUT -p tcp --dport 443 --syn -m limit --limit 5/sec -j ACCEPT
iptables -A INPUT -p tcp --dport 443 --syn -j DROP

