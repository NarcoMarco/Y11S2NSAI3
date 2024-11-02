#!/bin/sh

# Update system
apk update

# Install packages
apk add iproute2 busybox-extras

# Configure Network
ip addr add 192.168.0.18/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.0.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Run script to talk to quickchat server
# sh /scripts/telnet-pword-message.sh &