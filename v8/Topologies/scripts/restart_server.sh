#!/bin/bash

# Infinite loop to restart the server if it stops
while true; do
    rm quickchat.db
    /scripts/server
    echo "Server stopped. Restarting..."
    sleep 2  # Optional delay before restarting
done
