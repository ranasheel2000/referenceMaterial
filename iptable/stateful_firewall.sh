#!/bin/bash

###*** FIREWALL FOR A DESKTOP OPERATING SYSTEM ***###

#flush filter table from all chains
iptables -F 

#allow loopback interface traffic 
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT


#drop invalid packets on INPUT and OUTPUT CHAINS
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP


#optional, uncomment the line if you want to allow incoming connections from our LAN
#iptables -A INPUT -s 192.168.0.0/24 -j ACCEPT

#optional, uncomment the line if you want to allow incoming ssh connection from a specific ip address
#iptables -A INPUT -p tcp --dport 22 --syn -s 80.0.0.1 -j ACCEPT

#allow only ESTABLISHED and RELATED packets on INPUT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#allow also NEW packets on OUTPUT (packets that initialize connections)
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT


#set policy to DROP on INPUT and OUTPUT CHAINS
iptables -P INPUT DROP
iptables -P OUTPUT DROP
