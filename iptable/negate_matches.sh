#!/bin/bash

iptables -F

# dropping all incoming ssh traffic accepting packets from 100.0.0.1 (management station)
iptables -A INPUT -p tcp --dport 22 ! -s 100.0.0.1 -j DROP


# dropping all outgoing https traffic excepting to www.linux.com
iptables -A OUTPUT -p tcp --dport 443 ! -d www.linux.com -j DROP


# dropping all communication excepting that with the  default gateway (mac is  b4:6d:83:77:85:f4)
iptables -A INPUT -m mac ! --mac-source b4:6d:83:77:85:f4 -j DROP

iptables -P INPUT ACCEPT



