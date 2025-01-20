#!/bin/sh

while true; do
  # Get the current time in hours and minutes
  current_time=$(date +"%H:%M")

  # Check if it's 01:00
  if [ "$current_time" = "20:00" ]; then
    echo "Time to restart the container"
    # Kill the Java process or exit the script to crash the container
    pkill java
    exit 1
  fi

  # Sleep for 60 seconds before checking the time again
  sleep 60
done
