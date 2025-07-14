#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: nvim-setup.sh
# Purpose: Installs Neovim configuration with install plugins in headless mode
# Usage: ./nvim-setup.sh
# ----------------------------------------------------------------------------

source ../utils.sh

readonly CONFIG_REPO="https://github.com/LazyDoomSlayer/nvim-configuration"
readonly CONFIG_DIR="${HOME}/.config/nvim"

log "Installing Neovim configuration from: $CONFIG_REPO"

git clone "$CONFIG_REPO" "$CONFIG_DIR"

log "Running plugin sync with lazy.nvim..."
nvim --headless "+Lazy! sync" +qa

success "Neovim configuration installed and all plugins synced."
