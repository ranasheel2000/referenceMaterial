#!/bin/bash
iptables -F
iptables -A INPUT -p tcp --dport 22 -j LOG
iptables -A INPUT -p tcp --dport 22 -j DROP
