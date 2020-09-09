#!/bin/bash

iptables -F INPUT


### FILTER BY PORT (-p tcp|udp --sport | --dport) ###

# ALLOW SSH CONNECTIONS ONLY FROM ONE IP ADDRESS
# dropping incoming packets to port 22 except if they are coming from 80.0.0.1
iptables -A INPUT -p tcp --dport 22 -s 80.0.0.1 -j ACCEPT
# it's possible to specify port using service name (/etc/services)
# iptables -A INPUT -p tcp --dport ssh -s 80.0.0.1 -j ACCEPT

# dropping all other ssh traffic
iptables -A INPUT -p tcp --dport 22 -j DROP

# allowing DNS Queries
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT


### FILTER BY PROTOCOL (-p) ###

# dropping incoming GRE traffic
iptables -A INPUT -p gre -j DROP

# allowing outgoing ICMP traffic
iptables -A OUTPUT -p icmp -j DROP


### FILTER BY INTERFACE (-i | -o) ###

# allowing loopback interface traffic (always recommended)
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# dropping ssh traffic that's coming on eth0 interface (suppose it's external)
iptables -A INPUT -p tcp --dport 22 -i eth0 -j DROP

# allowing ssh traffic that's coming on eht1 interface (suppose it's internal)
iptables -A INPUT -p tcp --dport 22 -i eth1 -j ACCEPT

# allowing outgoing https traffic via eth1
iptables -A OUTPUT -p tcp --dport 443 -o eth1 -j ACCEPT
