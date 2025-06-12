#!/bin/bash

# Print the logo
print_logo() {
  cat <<"EOF"
 _                       
| |    __ _ _____   _     
| |   / _` |_  / | | |                                     
| |__| (_| |/ /| |_| |                                     
|_____\__,_/___|\__, |       ____  _                       
|  _ \  ___   __|___/__ ___ / ___|| | __ _ _   _  ___ _ __ 
| | | |/ _ \ / _ \| '_ ` _ \\___ \| |/ _` | | | |/ _ \ '__|
| |_| | (_) | (_) | | | | | |___) | | (_| | |_| |  __/ |   
|____/ \___/ \___/|_| |_| |_|____/|_|\__,_|\__, |\___|_|   
                                           |___/           
EOF
}

print_logo

# Source utility functions
source utils.sh

# Source the package list
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source packages.conf

# Update the system first
echo "Updating system..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Node for development
echo "Installing Node.js with npm, yarn, pnpm"
../node-setup.sh

echo "Setup complete! You may want to reboot your system."
