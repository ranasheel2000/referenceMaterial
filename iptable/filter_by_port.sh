#!/bin/bash

iptables -F INPUT


#ALLOW SSH CONNECTIONS ONLY FROM ONE IP ADDRESS

#drop packets to port 22 except if they are coming from 80.0.0.1
iptables -A INPUT -p tcp --dport 22 -s 80.0.0.1 -j ACCEPT
#is possible to specify port using service name (/etc/services)
#iptables -A INPUT -p tcp --dport ssh -s 80.0.0.1 -j ACCEPT


iptables -A INPUT -p tcp --dport 22 -j DROP
