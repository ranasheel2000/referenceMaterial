#!/bin/bash
iptables -F
iptables -X

# creating a user-defined chain
iptables -N TCP_TRAFFIC

# add rules to the chain
iptables -A TCP_TRAFFIC -p tcp -j ACCEPT

# jump to the chain from the input chain
iptables -A INPUT -p tcp -j TCP_TRAFFIC


# flush all rules in the chain
iptables -F TCP_TRAFFIC

# delete the chain
iptables -X TCP_TRAFFIC
