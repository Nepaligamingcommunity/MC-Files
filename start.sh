#!/bin/bash

set -e  # Stop on error

sudo apt update
sudo apt upgrade -y

clear
echo "🌐 Starting Smart Minecraft Server Setup..."

# === Function: Check if a command exists ===
is_installed() {
  command -v "$1" >/dev/null 2>&1
}

sudo apt install -y screen

# === Install Java 21 ===
if java -version 2>&1 | grep -q "21"; then
  echo "✅ Java 21 already installed. Skipping."
else
  echo "🔧 Installing Java 21..."
  if [ ! -f jdk-21.0.6_linux-x64_bin.deb ]; then
    wget https://download.oracle.com/java/21/archive/jdk-21.0.6_linux-x64_bin.deb || { echo "❌ Failed to download Java. Exiting."; exit 1; }
  fi
  sudo dpkg -i jdk-21.0.6_linux-x64_bin.deb || { echo "❌ Failed to install Java. Exiting."; exit 1; }
  sudo apt remove --purge openjdk-17-jdk openjdk-17-jre -y
sudo apt autoremove -y
fi

# === Download PaperMC ===
if [ -f server.jar ]; then
  echo "✅ server.jar already exists. Skipping download."
else
 wget -O server.jar 
# === Add Playit repo and key ===
if is_installed playit; then
  echo "✅ playit already installed. Skipping."
else
  echo "🔧 Installing playit..."
  if [ ! -f /etc/apt/trusted.gpg.d/playit.gpg ]; then
    curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
  fi
  if [ ! -f /etc/apt/sources.list.d/playit-cloud.list ]; then
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list
  fi
  sudo apt update
  sudo apt install -y playit || { echo "❌ Failed to install playit. Exiting."; exit 1; }
fi

# === Accept EULA ===
if grep -q "eula=true" eula.txt 2>/dev/null; then
  echo "✅ EULA already accepted. Skipping."
else
  echo "📜 Accepting EULA..."
  echo "eula=true" > eula.txt
fi

if [ -f setup.sh ]; then
  echo "✅ setup.sh already exists. Skipping download."
else
wget -O setup.sh https://raw.githubusercontent.com/Nepaligamingcommunity/OFFICIAL-FILES/main/setup.sh
chmod +x setup.sh
fi

echo "🚀 Launching Minecraft server..."
java -Xms5G -Xmx10G -jar server.jar --nogui || { echo "❌ Server failed to start. Check logs."; exit 1; }

./setup.sh
./server.sh
