# Use an OpenJDK image as base
FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /geyser

# Set timezone to Europe/Brussels
ENV TZ=Europe/Brussels

# Copy the configuration files into the container
COPY ./src /geyser

# Install necessary packages and set timezone
RUN apt-get update && apt-get install -y curl tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose the port used by GeyserMC
EXPOSE 19132

# Copy a script that handles the scheduled shutdown
COPY start.sh /geyser/start.sh

# Make the script executable
RUN chmod +x /geyser/start.sh

# Start GeyserMC and the restart script
CMD ["sh", "/geyser/start.sh"]
