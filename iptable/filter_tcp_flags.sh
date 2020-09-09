#!/bin/bash

# flushing the firewall
iptables -F

# dropping all incoming tcp packets that have syn set
iptables -A INPUT -p tcp --syn -j DROP


# logging outgoing traffic that has syn and ack set
iptables -A OUTPUT -p tcp --tcp-flags syn,ack,rst,fin syn,ack -j LOG
