#!/bin/bash

#script usage: ./block_from_ip IP_ADDRESS_TO_BE DROPPED
#Ex: ./block_from_ip 80.0.0.0/16

#$1 is the first argument of the script
echo "Dropping packets from $1"

#drops any incoming packet from the IP or network address, that was specified as the script 1st argument
iptables -I INPUT -s $1 -j DROP
echo "Done"

