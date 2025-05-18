echo "🚀 Launching Minecraft server..."
java -Xms5G -Xmx10G -jar server.jar --nogui || { echo "❌ Server failed to start. Check logs."; exit 1; }
