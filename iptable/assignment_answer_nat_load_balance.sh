#!/bin/bash

#web 80 443
#email 25 465 143 993 110 995
#ssh 22
##traffic routed using isp1 connection
ISP1="22 25 80 110 143 443 465 993 995"

#clear nat tables on POSTROUTING CHAIN
iptables -t nat -F POSTROUTING

#enable routing process
echo "1" > /proc/sys/net/ipv4/ip_forward

for port in $ISP1
do
    #nat traffic using eth1 (isp1)
	iptables -t nat -A POSTROUTING -p tcp --dport $port -o eth1 -j MASQUERADE
done 

#route traffic through ISP2
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE

