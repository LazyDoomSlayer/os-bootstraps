#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: tpm-setup.sh
# Purpose: Installs Tmux Plugin Manager (TPM) on Ubuntu and launches tmux to install plugins
# Usage: ./tpm-setup.sh
# ----------------------------------------------------------------------------

source ../utils.sh

log "Starting TPM (Tmux Plugin Manager) setup for Ubuntu..."

# Verify tmux is installed
if ! dpkg -s tmux &>/dev/null; then
  error "tmux is not installed. Please run: sudo apt install tmux"
  exit 1
fi

success "tmux is installed ✅"

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Install TPM if not present
if [ -d "$TPM_DIR" ]; then
  success "TPM is already installed at $TPM_DIR"
else
  log "Cloning TPM into $TPM_DIR..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  success "TPM cloned successfully 🎉"
fi

# Install plugins
log "Installing tmux plugins via TPM..."
"$TPM_DIR/bin/install_plugins"
success "TPM setup and plugin installation complete!"
