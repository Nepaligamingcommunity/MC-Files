if [ -f start.sh ]; then
    rm start.sh
    echo "Deleted start.sh"
fi

if [ -f setup.sh ]; then
    rm setup.sh
    echo "Deleted setup.sh"
fi

echo "🚀 Launching Minecraft server..."
java -Xms5G -Xmx10G -jar server.jar --nogui || { echo "❌ Server failed to start. Check logs."; exit 1; }
