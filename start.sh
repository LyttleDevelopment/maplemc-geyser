#!/bin/sh

# Always download the latest GeyserMC standalone jar at runtime
echo "Downloading the latest GeyserMC standalone jar..."
curl -sL https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/standalone -o geyser.jar
echo "Download complete."

# Check if the "KEY_BASE64" environment variable is set
if [ -z "$KEY_BASE64" ]; then
  echo "Error: The KEY_BASE64 environment variable is not set."
  exit 1
else
  # Decode the Base64-encoded key and write to key.pem
  echo "$KEY_BASE64" | base64 -d > /geyser/key.pem
  echo "key.pem file has been created from Base64 encoded key."
fi

# Replace placeholder in config.yml with BACKEND_SERVER environment variable
if [ -z "$BACKEND_SERVER" ]; then
  echo "Error: The BACKEND_SERVER environment variable is not set."
  exit 1
else
  sed -i "s/\${BACKEND_SERVER}/$BACKEND_SERVER/" /geyser/config.yml
  echo "config.yml updated with BACKEND_SERVER: $BACKEND_SERVER"
fi

# Background task to monitor time and stop the container
(
  while true; do
    # Get the current time in hours and minutes
    current_time=$(date +"%H:%M")

    # Check if it's 20:00 (or any other specified time)
    if [ "$current_time" = "20:00" ]; then
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
