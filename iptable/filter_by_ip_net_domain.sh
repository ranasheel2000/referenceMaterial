#!/bin/bash

# flushing the firewall
iptables -F

# dropping all traffic from 100.0.0.1
iptables -A INPUT -s 100.0.0.1 -j DROP

# accepting all ssh traffic from network 80.0.0.0/16
iptables -A INPUT -s 80.0.0.0/16 -j ACCEPT

# dropping all outgoing HTTPS traffic to www.ubuntu.com (dns traffic must be permitted)
iptables -A OUTPUT -p tcp --dport 443 -d www.ubuntu.com -j DROP
