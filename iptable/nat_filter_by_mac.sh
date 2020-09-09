#!/bin/bash

# this scrips permits routed traffic (this is the Router) only for some MAC addresses

# flush the filter table / FORWARD CHAIN
iptables -F FORWARD

# variable that contains the pemitted MAC addresses
PERMITED_MACS="08:00:27:c8:75:38 08:00:27:c8:75:ab"


# itarating over the list with allowed MAC addresses
for MAC in $PERMITED_MACS
do
	# permit routed traffic that enters enp0s3 interface (internal, lan interface) with 
	# source MAC address from $MAC variable 
	iptables -A FORWARD -i enp0s3 -m mac --mac-source $MAC -j ACCEPT
done

# Drop any other packet (with another source MAC addresse)
iptables -A FORWARD -i enp0s3 -j DROP
