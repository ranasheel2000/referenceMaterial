#!/bin/bash

#$1 is the protocol we are blocking (TCP or UDP)
#$2 is the port we are blocking
#Usage: ./block_service.sh tcp 8080

#$# represents the no. of script argument
#if run with 2 arguments
if [ $# -eq 2 ]
then
	echo "Blocking $1 port $2"
	#block that protocol & port
	iptables -I INPUT -p $1 --dport $2 -j DROP 
	echo "Done"
else	#if not run with 2 arguments
	echo "The script has been  run with the wrong number of arguments"
fi
