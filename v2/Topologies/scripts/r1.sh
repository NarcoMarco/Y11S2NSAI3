configure terminal

# Configure server port
interface eth1
ip address 192.168.143.1/24

# Configure admin switch
interface eth2
ip address 10.13.37.1/24

# Configure client switch
interface eth3
ip address 192.168.0.1/24

end
write memory
exit