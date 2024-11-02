#!/bin/sh 

echo "setting up router"

vtysh << EOF
configure terminal
interface eth1
 ip address 192.168.143.1/24
interface eth2
 ip address 192.168.144.1/24
interface eth3
 ip address 10.13.37.1/24
interface eth4
 ip address 10.13.38.1/24
interface eth5
 ip address 192.168.0.1/24
interface eth6
 ip address 192.168.1.1/24
interface eth7
 ip address 192.168.2.1/24
end
write memory
EOF