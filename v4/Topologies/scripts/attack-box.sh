#!/bin/sh

# Update the system
apk update

# Install packages
apk add iproute2 openssh openrc bash termshark nmap busybox-extras

# Configure network
ip addr add 192.168.2.47/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.2.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Add hackerman user
adduser -D hackerman 
echo 'hackerman:hackerman' | chpasswd

# Add hackerman to wireshark group
adduser hackerman wireshark

# Configure ssh
# Ensure OpenRC directories exist
mkdir -p /run/openrc
touch /run/openrc/softlevel

# Start and enable rsyslog
rc-service rsyslog start
rc-update add rsyslog

sh /config/services.sshd.sh 22
rc-status -a

rc-service sshd start
rc-update add sshd

rc-status -a