#!/bin/sh

# Update system
apk update

# Install packages
apk add iproute2 openssh openrc bash termshark nmap busybox-extras

# Configure Network
ip addr add 192.168.0.18/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.0.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Add John user
adduser -D John 
echo 'John:camaro' | chpasswd

# Add John to wireshark group
adduser John wireshark

# Configure ssh
# Ensure OpenRC directories exist
mkdir -p /run/openrc
touch /run/openrc/softlevel

# Start and enable rsyslog
rc-service rsyslog start
rc-update add rsyslog

# Configure SSHD settings
echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
echo 'ChallengeResponseAuthentication no' >> /etc/ssh/sshd_config
echo 'UsePAM no' >> /etc/ssh/sshd_config

sh /config/services.sshd.sh 22
rc-status -a

rc-service sshd start
rc-update add sshd

rc-status -a

sleep 10

# Run telnet script
sh /scripts/telnet/telnet-recieve.sh &

sudo chown root:root /host/path/to/scripts
sudo chmod 700 /host/path/to/scripts

exit 0