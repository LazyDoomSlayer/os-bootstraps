#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: tmux-config-setup.sh
# Purpose: Clones custom tmux configuration, installs it, and sources the new config
# Usage: ./tmux-config-setup.sh
# ----------------------------------------------------------------------------

echo "Starting tmux configuration setup..."

# Ensure git is installed
if ! command -v git &>/dev/null; then
  echo "Error: git is not installed. Please install git first (e.g., sudo apt-get install git)."
  exit 1
fi

echo "Cloning tmux-configuration repository..."
CLONE_DIR="/tmp/tmux-configuration"

# Remove existing clone if present
i[ -d "$CLONE_DIR" ] && rm -rf "$CLONE_DIR"

git clone https://github.com/LazyDoomSlayer/tmux-configuration.git "$CLONE_DIR"

# Copy .tmux.conf to home directory
echo "Copying .tmux.conf to ~/.tmux.conf..."
cp "$CLONE_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Source the new configuration in any running tmux session
echo "Sourcing ~/.tmux.conf in existing tmux sessions..."
if command -v tmux &>/dev/null && tmux ls &>/dev/null; then
  tmux source-file "$HOME/.tmux.conf"
  echo "Configuration sourced."  
else
  echo "No active tmux sessions found. Changes will apply on next tmux start."
fi

# Cleanup
echo "Cleaning up temporary files..."
rm -rf "$CLONE_DIR"

echo "tmux configuration setup complete!"

