#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: nvim-setup.sh
# Purpose: Installs Neovim configuration with install plugins in headless mode
# Usage: ./nvim-setup.sh
# ----------------------------------------------------------------------------

readonly CONFIG_REPO="https://github.com/LazyDoomSlayer/nvim-configuration"
readonly CONFIG_DIR="${HOME}/.config/nvim"

echo "Installing Neovim configuration from: $CONFIG_REPO"

git clone "$CONFIG_REPO" "$CONFIG_DIR"

echo "Running plugin sync with lazy.nvim..."
nvim --headless "+Lazy! sync" +qa

echo "Neovim configuration installed and all plugins synced."
