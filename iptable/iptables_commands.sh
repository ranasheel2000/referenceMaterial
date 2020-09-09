#!/bin/bash

# -A -> appends a rule at the end of the CHAIN
iptables -A OUTPUT -p tcp --dport 443 -j DROP


# -I -> inserts a rule on top (1st position) of the CHAIN
iptables -I OUTPUT -p tcp --dport 443 -d www.linux.com -j ACCEPT

# -F -> flushes the CHAIN
iptables -t filter -F OUTPUT


# -Z -> zeroises the packet and byte counters
iptables -t filter -Z

# -D -> deletes a rule
iptables -D OUTPUT 2

# -P -> sets the default POLICY
iptables -P INPUT ACCEPT

# -N -> creates a user-defined CHAIN
iptables -N TCP_TRAFFIC

# -X -> delete a user-defined CHAIN
iptables -X TCP_TRAFFIC
