#!/bin/bash

# By default POLICY is ACCEPT on all CHAINS

# !!! If there is no rule that accepts packets and the policy is set to drop, all traffic will be dropped.
# Change the default policy with caution!


# Setting the DROP Policy on FORWARD chain
iptables -P FORWARD DROP

# Setting the ACCEPT Policy on OUTPUT chain
iptables -P OUTPUT ACCEPT

# Setting the DROP Policy on INPUT chain
iptables -P INPUT DROP
