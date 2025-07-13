#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: rust-setup.sh
# Purpose: Installs rustup for rust development headless.
# Usage: ./rust-setup.sh
# ----------------------------------------------------------------------------

echo "Starting Rust development environment setup..."

echo "Installing rustup via curl headless..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

echo "Setup complete!"
