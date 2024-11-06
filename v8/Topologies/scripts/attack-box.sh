#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# Update the system
apt update

# Install packages
apt install -y iproute2 openssh-server bash termshark nmap hydra lftp busybox iputils-ping steghide

# Configure network
ip addr add 192.168.0.47/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.0.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Add hackerman user
useradd -m -s /bin/bash hackerman
echo 'hackerman:hackerman' | chpasswd

# Add hackerman to wireshark group
groupadd wireshark 2>/dev/null
usermod -aG wireshark hackerman

service ssh start

cp /scripts/brute-force/10k-most-common.txt /home/hackerman/
cp /scripts/Hints/hint.txt /home/hackerman/
