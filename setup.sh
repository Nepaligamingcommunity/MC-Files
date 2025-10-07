#!/bin/bash

# Change to plugins directory
cd plugins || { echo "'plugins' directory not found!"; exit 1; }

# Ask user
read -p "Do you want to play it on Bedrock (Y/N)? " choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

# If yes, download Bedrock server
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    echo "Downloading Minecraft Bedrock server..."
    wget -O geyser.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot
    wget -O floodgate.jar https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot
    wget -O viaverson.jar https://cdn.modrinth.com/data/P1OZGk5p/versions/GCr8TC4U/ViaVersion-5.5.0.jar
    wget -O viabackwards.jar https://cdn.modrinth.com/data/NpvuJQoq/versions/LSf7EvPT/ViaBackwards-5.5.0.jar

    echo "Download complete."
fi
cd ..
sed -i 's/^online-mode=true/online-mode=false/' server.properties
read -p "Press Enter to continue..."

echo "🚀 Launching Minecraft server..."
java -Xms5G -Xmx10G -jar server.jar --nogui || { echo "❌ Server failed to start. Check logs."; exit 1; }
