cd plugins/Geyser-Spigot
sed -i 's/^auth-type: online/auth-type: floodgate/' config.yml
read -p "Press Enter to continue..."

cd ..
cd..
if [ -f start.sh ]; then
    rm start.sh
    echo "Deleted start.sh"
else
    echo "File start.sh does not exist."
fi
if [ -f setup.sh ]; then
    rm start.sh
    echo "Deleted setup.sh"
else
    echo "File setup.sh does not exist."
fi
