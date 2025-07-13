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

clear
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

# Install all packages
echo "[APT] Installing system utilities..."
install_apt_packages "${SYSTEM_UTILS_APT[@]}"

echo "[APT] Installing development tools..."
install_apt_packages "${DEV_TOOLS_APT[@]}"

echo "[SNAP] Installing system utilities..."
install_snap_packages "${SYSTEM_UTILS_SNAP[@]}"

echo "[SNAP] Installing development tools..."
install_snap_packages "${DEV_TOOLS_SNAP[@]}"

readonly SCRIPTS=(
  "../node-setup.sh"
  "../rust-setup.sh"
  "docker-setup.sh"
  "lazygit-setup.sh"
  "python-setup.sh"
  "zoxide-setup.sh"
  "tmux-config-setup.sh"
  "tpm-setup.sh"
  "nvim-setup.sh"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting bootstrapping at $(date)"
for rel in "${SCRIPTS[@]}"; do
  run_script "$SCRIPT_DIR/$rel"
done

# Cleanup
echo "Cleaning up apt packages..."
sudo apt autoremove -y

echo "Setup complete! You may want to reboot your system."
