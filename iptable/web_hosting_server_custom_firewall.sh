#!/bin/bash


#flush the filter table from INPUT, OUTPUT and FORWARD CHAINS
iptables -F

#permit loopback interface traffic - recommended
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#drop invalid packets
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP


#allow icmp traffic - recommended
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

#allowed incoming tcp ports
PERMIT_TCP="20 21 465 80 443 110 143 993 44 2232 89 1111"

for PORT in $PERMIT_TCP
do
	iptables -A INPUT -p tcp --dport $PORT -j ACCEPT
done

#allow incoming DNS Traffic
iptables -A INPUT -p udp --dport 53 -j ACCEPT

#IP addresses allowed to connect using ssh 
PERMIT_SSH="192.168.0.145 3.4.5.1 89.0.1.1 90.0.0.1"
for IP in $PERMIT_SSH 
do
	iptables -A INPUT -p tcp --dport 22 -s $IP -j ACCEPT
done



#permit no more that 50 concurent connections from the same ip address to our web server
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m connlimit --connlimit-above 50 -j DROP


#permit all traffic from the fallowing mac addresses
ALLOWED_MAC="08:00:27:65:5c:3c  08:00:27:65:5c:41  08:00:27:65:5c:ab  08:00:27:65:5c:23"
for MAC in $ALLOWED_MAC
do
	iptables -A INPUT -m mac --mac-source $MAC -j ACCEPT
done

#permit any packet on OUTPUT chain except INVALID
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT


#set default policy DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP
