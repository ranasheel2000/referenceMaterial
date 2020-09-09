#!/bin/bash

iptables -F INPUT

iptables -A INPUT -p tcp -m connlimit --connlimit-above 20 -j DROP
