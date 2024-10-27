#!/bin/sh

# Update the system
apk update

# Configure network
apk add iproute2
ip addr add 192.168.0.47/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.0.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Add hackerman user
adduser -s hackerman

# Configure ssh
apk add openssh openrc bash

rc-update add sshd

service sshd start

exit