#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: zoxide-setup.sh
# Purpose: Configures Zoxide for better change directory experiance
# Usage: ./zoxide-setup.sh
# ----------------------------------------------------------------------------

source ../utils.sh

# Zoxide init
ZOX_LINE='eval "$(zoxide init bash)"'

# Add to ~/.bashrc if not present
if ! grep -Fxq "$ZOX_LINE" ~/.bashrc; then
  log "Adding zoxide initialization to ~/.bashrc..."
  {
    echo ""
    echo "# Initialize zoxide"
    echo "$ZOX_LINE"
  } >>~/.bashrc
  success "zoxide init added to ~/.bashrc"
else
  warn "zoxide init already present in ~/.bashrc"
fi

log "Reloading ~/.bashrc..."

source ~/.bashrc
success "zoxide setup complete!"
