#!/bin/bash


#flushing the filter table of all chains
iptables -F


# ACCEPT target is terminating one. If the packet is accepted, no other rule will evaluate the packet
# ACCEPTing incoming ssh packets (port tcp/22) from any IP address
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# DROP any other tcp packets 
iptables -A INPUT -p tcp -j DROP


# DROP is a terminating target. If a packet was dropped by the last rule, no other rule will evaluate the packet

# the next rule will never be evaluated. No packet will be matched against it.
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
