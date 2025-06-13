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

echo "Launching tmux session to install plugins..."

# Plugin installation
SESSION_NAME="tpm_install"
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session $SESSION_NAME already exists. Killing it first..."
  tmux kill-session -t "$SESSION_NAME"
fi

tmux new-session -d -s "$SESSION_NAME"

# Trigger TPM install command
echo "Sending TPM install command (Prefix + I)..."
tmux send-keys -t "$SESSION_NAME" C-b "I" C-m

# Attach to the session
echo "Attaching to tmux session $SESSION_NAME..."
tmux attach-session -t "$SESSION_NAME"

echo "TPM setup and plugin installation complete!"

exit 0
