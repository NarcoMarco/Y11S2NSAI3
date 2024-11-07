#!/bin/sh

HOST="192.168.143.10"
PORT="8080"

# Function to send messages via telnet
send_message() {
    (   
        sleep 1
        # Sending initial set of messages
        echo "register"
        sleep 1
        echo "clientOne"
        sleep 1
        echo "SuperSecretPassword"
        
        # Loop to repeatedly send a message indefinitely
        while true; do
            echo "The admin password for the webserver was NotS3cuR3P@ssW0rd"
            sleep 0.5
            echo "John"
            sleep 5  # Adjust delay as needed
        done
    ) | telnet "$HOST" "$PORT" >> dev/null
}

# Run the function
while true; do
    send_message
    # If telnet exits, wait before retrying
    sleep 5
done