if [ -f start.sh ]; then
    rm start.sh
    echo "Deleted start.sh"
else
    echo "File start.sh does not exist."
fi

echo "🚀 Launching Minecraft server..."
java -Xms5G -Xmx10G -jar server.jar --nogui || { echo "❌ Server failed to start. Check logs."; exit 1; }
