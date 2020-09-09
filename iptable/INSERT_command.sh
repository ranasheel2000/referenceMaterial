#!/bin/bash
iptables -F

# Using -I instead of -A in the last rule makes the rule to be
# the first rule on the INPUT CHAIN => ALL SSH TRAFFIC IS DROPPED
iptables -t filter -I INPUT -s 192.168.0.20 -p tcp --dport 22 -j ACCEPT # last rule
iptables -t filter -I INPUT -s 192.168.0.5 -p tcp --dport 22 -j ACCEPT  # second rule

iptables -I INPUT -p tcp --dport 22 -j DROP	#first rule 
