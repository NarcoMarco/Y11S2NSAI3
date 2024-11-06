#!/bin/sh 

echo "setting up router"

# Create server bridge

# Create bridge
ip link add name br0 type bridge

# Add interfaces to bridge
ip link set dev eth1 master br0
ip link set dev eth2 master br0

# Assign IP to the bridge
ip addr add 192.168.143.1/24 dev br0

# Bring up bridge and members
ip link set dev br0 up
ip link set dev eth1 up
ip link set dev eth2 up

echo "Server Bridge setup complete"

# Create admin bridge

# Create bridge
ip link add name br1 type bridge

# Add interfaces to bridge
ip link set dev eth3 master br1
ip link set dev eth4 master br1

# Assign IP to the bridge
ip addr add 10.13.37.1/24 dev br1

# Bring up bridge and members
ip link set dev br1 up
ip link set dev eth3 up
ip link set dev eth4 up

echo "Admin Bridge setup complete"

# Create client bridge

# Create Bridge
ip link add name br2 type bridge

# Add interfaces to the bridge
ip link set dev eth5 master br2
ip link set dev eth6 master br2
ip link set dev eth7 master br2

# add vulnerability maybe
sudo ip link set dev eth5 type bridge_slave hairpin on
sudo ip link set dev eth6 type bridge_slave hairpin on
sudo ip link set dev eth7 type bridge_slave hairpin on

# Assign IP to the bridge instead of individual interfaces
ip addr add 192.168.0.1/24 dev br2

# Bring up the bridge and its member interfaces
ip link set dev br2 up
ip link set dev eth5 up
ip link set dev eth6 up
ip link set dev eth7 up

# Enable IP forwarding for routing
sysctl -w net.ipv4.ip_forward=1

echo "Client Bridge setup complete"

 