#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: zoxide-setup.sh
# Purpose: Installs Zoxide for better change directory experiance
# Usage: ./zoxide-setup.sh
# ----------------------------------------------------------------------------

# Install zoxide
echo "Installing zoxide..."
sudo apt install zoxide -y

# Zoxide init
ZOX_LINE='eval "$(zoxide init bash)"'

# Check ~/.bashrc
if ! grep -Fxq "$ZOX_LINE" ~/.bashrc; then
  echo "Adding zoxide init to ~/.bashrc..."
  echo "" >>~/.bashrc
  echo "# Initialize zoxide" >>~/.bashrc
  echo "$ZOX_LINE" >>~/.bashrc
else
  echo "zoxide init already present in ~/.bashrc"
fi

# Reload ~/.bashrc
echo "Reloading ~/.bashrc..."
source ~/.bashrc

echo "zoxide setup complete."
