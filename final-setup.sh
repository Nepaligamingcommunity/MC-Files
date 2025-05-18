cd plugins/Geyser-Spigot
sed -i 's/^auth-type: online/auth-type: floodgate/' server.properties
read -p "Press Enter to continue..."

cd ..
cd..
if [ -f start.sh ]; then
    rm start.sh
    echo "Deleted start.sh"
else
    echo "File start.sh does not exist."
fi
