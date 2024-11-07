#!/bin/sh

# Install packages
apk update
apk add python3 py3-pip

# Configure network
ip addr add 192.168.143.11/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.143.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

# Configure webserver
mkdir /app
cd /app

python3 -m venv /app

source /app/bin/activate

pip3 install flask

cp /scripts/webserver/app.py ./

python3 /app/app.py &