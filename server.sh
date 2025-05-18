if [ -f start.sh ]; then
    rm start.sh
    echo "Deleted start.sh"
else
    echo "File start.sh does not exist."
fi
