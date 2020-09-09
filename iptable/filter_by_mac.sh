#!/bin/bash


##** FILTER BY MAC ADDRESS (only source) **##

iptables -F INPUT

# defining a variable that contains the allowed MAC addresses
PERMITTED_MACS="08:00:27:15:b2:ec 08:00:27:15:b2:df 08:00:27:15:b2:ab"

# this host can communicate only with other hosts inside our LAN that have
# a MAC address from this list 
# !!! to be able to communicate outside the LAN (e.g. Internet) the MAC 
# of the router internal interface should also be allowed
for MAC in $PERMITTED_MACS
do
	iptables -A INPUT -m mac --mac-source $MAC -j ACCEPT
	echo "$MAC permitted"
done


# set POLICY to DROP on INPUT (all other packets are dropped)
iptables -P INPUT DROP


