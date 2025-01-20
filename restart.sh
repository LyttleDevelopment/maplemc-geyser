#!/bin/sh

# Background task to monitor time and stop the container
(
  while true; do
    # Get the current time in hours and minutes
    current_time=$(date +"%H:%M")

    # Check if it's 20:00 (or any specified time)
    if [ "$current_time" = "01:00" ]; then
      echo "Time to stop the container"
      # Exit the main shell to stop the container
      kill 1
    fi

    # Sleep for 60 seconds before checking the time again
    sleep 60
  done
) &

# Start the GeyserMC server
exec java -jar geyser.jar
