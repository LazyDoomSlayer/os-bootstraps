#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: tpm-setup.sh
# Purpose: Installs Tmux Plugin Manager (TPM) on Ubuntu and launches tmux to install plugins
# Usage: ./tpm-setup.sh
# ----------------------------------------------------------------------------

echo "Starting TPM setup for Ubuntu..."

# Verify tmux
if ! dpkg -s tmux &>/dev/null; then
  echo "Error: tmux is not installed. Please install tmux first (e.g., sudo apt-get install tmux)."
  exit 1
fi

echo "tmux is installed."

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Install TPM
if [ -d "$TPM_DIR" ]; then
  echo "TPM is already installed at $TPM_DIR"
else
  echo "Cloning TPM into $TPM_DIR..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "TPM cloned successfully."
fi

# Install plugins quiet
echo "Installing tmux plugins via TPM..."
"$TPM_DIR/bin/install_plugins"

echo "TPM setup and plugin installation complete!"
