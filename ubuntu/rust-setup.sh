#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: rust-setup.sh
# Purpose: Installs rustup for rust development headless.
# Usage: ./rust-setup.sh
# ----------------------------------------------------------------------------

source ./utils.sh

log "Starting Rust development environment setup..."

log "Installing rustup via curl headless..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

success "Rustup setup complete!"
