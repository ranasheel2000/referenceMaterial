#!/bin/bash

iptables -F

iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -N ACCEPTED_MAC

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT


iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:C7:6B -j ACCEPT
iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:C6:7C -j ACCEPT
iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:23:AB -j ACCEPT
iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:67:AA -j ACCEPT


iptables -P OUTPUT DROP
iptables -P INPUT DROP
