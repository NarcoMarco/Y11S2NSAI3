#!/bin/sh

HOST="192.168.143.10"
PORT="8080"

# Function to send messages via telnet
send_message() {
    (   
        sleep 1
        # Sending initial set of messages
        echo "login"
        sleep 1
        echo "clientOne"
        sleep 1
        echo "SuperSecretPassword"
        sleep 1
        echo "clientTwo"
        
        # Loop to repeatedly send a message indefinitely
        while true; do
            echo "Hey I wonder what this password could be? NotS3cuR3P@ssW0rd"
            sleep 5  # Adjust delay as needed
        done
    ) | telnet "$HOST" "$PORT"
}

# Run the function
send_message