#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: node-setup.sh
# Purpose: Installs NVM, Node.js, npm (via Node.js), and yarn & pnpm
# Usage: ./node-setup.sh
# ----------------------------------------------------------------------------

source ./utils.sh

# Install or update Node Version Manager
if [ -d "$HOME/.nvm" ]; then
  warn "NVM is already installed. Updating to latest..."
  cd "$HOME/.nvm" && git fetch --tags origin && git checkout "v0.40.3"
else
  log "Installing NVM v0.40.3..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Load NVM into the current shell session
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install Node.js LTS (v22)
NODE_VERSION="22"
log "Installing Node.js v$NODE_VERSION..."
nvm install "$NODE_VERSION"
nvm alias default "$NODE_VERSION"

# Verify Node.js and npm
log "Node.js version: $(node -v)"
log "Current NVM alias: $(nvm current)"

npm install -g pnpm
log "pnpm version: $(pnpm -v)"

npm install -g yarn
log "yarn version: $(yarn -v)"

# Yarn remove telemetry from yarn
yarn config set --home enableTelemetry 0

success "All done! Node.js, npm, yarn, and pnpm are now installed and configured."
