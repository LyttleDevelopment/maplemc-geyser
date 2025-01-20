# Use an OpenJDK image as base
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /geyser

# Copy the configuration files into the container
COPY ./src /geyser/src

# Command to download the latest GeyserMC standalone jar
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/standalone -o geyser.jar && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose the port used by GeyserMC
EXPOSE 19132

# Copy a script that handles the scheduled shutdown
COPY restart.sh /geyser/restart.sh

# Make the script executable
RUN chmod +x /geyser/restart.sh

# Start GeyserMC and the restart script
CMD ["sh", "-c", "sh /geyser/restart.sh & java -jar geyser.jar"]
