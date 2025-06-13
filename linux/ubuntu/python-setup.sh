#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: python-setup.sh
# Purpose: Installs pipx and ruff for Python development with informative output.
# Usage: ./python-setup.sh
# ----------------------------------------------------------------------------

echo "Starting Python development environment setup..."

echo "Installing pipx via apt..."
sudo apt install -y pipx

echo "Ensuring pipx user path is added to your shell..."
pipx ensurepath

# Optional global path setup
echo "Ensuring pipx global path is added (requires sudo)..."
sudo pipx ensurepath --global

echo "Installing ruff (a fast Python linter)..."
pipx install ruff

echo "Setup complete!"
