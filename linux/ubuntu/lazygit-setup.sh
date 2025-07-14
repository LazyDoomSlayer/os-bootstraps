#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: lazygit-setup.sh
# Purpose: Installs lazygit for Neovim plugin with informative output.
# Usage: ./lazygit-setup.sh
# ----------------------------------------------------------------------------

source ../utils.sh

log "Starting lazygit installation..."

log "Fetching latest lazygit version from GitHub..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')

log "Latest version detected: v${LAZYGIT_VERSION}"

log "Downloading lazygit v${LAZYGIT_VERSION}..."
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

log "Extracting lazygit binary..."
tar -xzf lazygit.tar.gz lazygit

log "Installing lazygit to /usr/local/bin..."
sudo install lazygit -D -t /usr/local/bin/

# Cleanup
log "Cleaning up temporary files..."
rm -f lazygit.tar.gz
rm -f lazygit

success "lazygit v${LAZYGIT_VERSION} installation complete!"
