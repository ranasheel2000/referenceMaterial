#!/bin/bash

iptables -F 

#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.10 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.11 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.12 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.13 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.14 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.15 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.16 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.17 -j DROP
#iptables -A INPUT -p tcp --dport 25 -s 10.0.0.18 -j DROP


#the 9 lines obove are replaced by:
iptables -A INPUT -p tcp --dport 25 -m iprange --src-range 10.0.0.10-10.0.0.18 -j DROP
