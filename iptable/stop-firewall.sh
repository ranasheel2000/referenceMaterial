#!/bin/bash

#1. Set the ACCEPT POLICY an all CHAINS

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

#2. flush all tables from all CHAINS
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F

#3.delete user-defined chains (if any)
iptables -X


