# Y11S2NSAI3
2024 Semester 2 ai4 Networking and Security

# Notes:
Containerlab will never give confirmation that it has finished building. This is because of an issue with the quickchat server where it crashes when scanned with nmap, and as such needs to be restarted. This script does not stay running unless it is run in the foreground with nohup, which doesn't allow containerlab to realise it is finished. 

# Challenge Overview
You have been given access to one machine on a network. Your goal is to gain access to a webserver accessible from your browser. You will use tools such as hydra and termshark in order to do this.


# Instuctions to complete
## Connecting to network
You can connect to the attack-box using the username and password "hackerman" on port 2222
```bash
ssh hackerman@<ip-address> -p 2222
password: hackerman
```

Reading the hint.txt file in the home directory tell you you will need hydra and termshark, as well as providing a list subnets.

Start by scanning the subnets:
```bash
nmap 192.168.0.0/24

nmap 192.168.143.0/24

nmap 10.13.37.10/24
```

We can see that on the 192.168.0.0/24 subnet, there is a machine with the ip address 192.168.0.18 that has an open ssh port. 

We can also see that a machine on the 192.168.143.0/24 subnet has an open port 8080 on ip 192.168.143.10, and an open port 5000 on ip 192.168.143.11.

The subnet 10.13.37.10/24 has no ports open, so we can ignore this as a red herring.

The hint file told us that there is a user named "John" that has ssh enabled. We should start there.

We can see that we also have a list of the top 10k passwords. Let's try using this to gain access to John's system.

```bash
hydra -l John -P 10k-most-common.txt ssh://192.168.0.18
```

This gives us the password "camaro". Now we can log into John's system
```bash
ssh John@192.168.0.18
password: camaro
```

Now that we have access to John's system, we can inspect packets that he is sending/recieving using termshark. using the ip a command, we can see that he is connected to the network using interface eth1.
```bash
termshark -i eth1
```

Although we could sift through this manually, we previously saw that there was a server with the ip address 192.168.143.10 with an open port. Let's see if John is talking to it. In the filters, we put:
```bash
ip.src == 192.168.143.10
```

This gives us a list of packets that are being sent to John from that server. By inspecting the contents of these packages, we can see a message:
```
The admin password for the webserver was NotS3cuR3P@ssW0rd
```

By now navigating to the website, we can use this admin password to login and get the flag.
