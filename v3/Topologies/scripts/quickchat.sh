#!/usr/bin/bash

apt update

apt install iproute2 sqlite3 -y

# Set ip address
ip addr add 192.168.143.2/24 dev eth1

# Configure routes
ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.143.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Run quickchat server
/scripts/server &