#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: python-setup.sh
# Purpose: Configures pipx and ruff for Python development.
# Usage: ./python-setup.sh
# ----------------------------------------------------------------------------

source ./utils.sh

log "Starting Python development environment setup..."

log "Ensuring pipx user path is added to your shell..."
pipx ensurepath
success "User path ensured"

log "Ensuring pipx global path is added (requires sudo)..."
sudo pipx ensurepath --global
success "Global path ensured"

log "Installing ruff (a fast Python linter)..."
pipx install ruff
success "ruff installed"

success "Python development setup complete!"
