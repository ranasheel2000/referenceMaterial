#!/bin/bash

iptables -F


## See all REJECT packets: iptables -j REJECT --help

# logging the first packet (tcp syn set) of any incoming ssh connection
# use the prefix: ###ssh: 
iptables -A INPUT -p tcp --syn --dport 22 -j LOG --log-prefix="##ssh:" --log-level info

# Then reject any incoming ssh packet and send back a tcp-reset to the source
iptables -A INPUT -p tcp --dport 22 -j REJECT --reject-with tcp-reset


# logging only 10 incoming ICMP ping packets per minute 
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 10/minute -j LOG --log-prefix="ping probe:"

# reject all incoming ICMP ping packets that are not coming from 10.0.0.1 (management station)
iptables -A INPUT ! -s 10.0.0.1 -p icmp --icmp-type echo-request -j REJECT --reject-with admin-prohib
