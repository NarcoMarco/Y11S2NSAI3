#!/bin/sh 

echo "setting up router"

vtysh << EOF
configure terminal

interface eth1
ip address 192.168.143.1/24

interface eth2
ip address 10.13.37.1/24

interface eth3
ip address 192.168.0.1/24

end
write memory
exit
EOF