#!/bin/bash
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -p tcp -j ACCEPT
iptables -A OUTPUT -p tcp -j ACCEPT

iptables -A INPUT -p udp -j ACCEPT
iptables -A OUTPUT -p udp -j ACCEPT
