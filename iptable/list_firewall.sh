#!/bin/bash


# listing the filter table of all chains (INPUT, OUTPUT and FORWARD)
iptables -t filter -L

# listing the filter table (it's default) of all chains, verbose (v) and in numeric format (n) 
iptables -vnL


# listing just a chain
iptables -vnL INPUT


# listing another table, not filter
iptables -t nat -vnL


# listing just a CHAIN
iptables -t nat -vnL POSTROUTING
