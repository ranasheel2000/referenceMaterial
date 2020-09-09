#!/bin/bash


#flushes filter table from all chains
iptables -F


#ACCEPT target is terminating one. If packet is accepted, no other rule will evalute the packet
#ACCEPT incoming ssh packets (port tcp/22) from any IP address
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#DROP any other tcp packets 
iptables -A INPUT -p tcp -j DROP
