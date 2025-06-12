#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: node-setup.sh
# Purpose: Installs NVM, Node.js, npm (via Node.js), and yarn & pnpm
# Usage: ./node-setup.sh
# ----------------------------------------------------------------------------

# Install or update Node Version Manager
if [ -d "$HOME/.nvm" ]; then
  echo "NVM is already installed. Updating to latest..."
  cd "$HOME/.nvm" && git fetch --tags origin && git checkout "v0.40.3"
else
  echo "Installing NVM v0.40.3..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Load NVM into the current shell session
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install Node.js LTS (v22)
NODE_VERSION="22"
echo "Installing Node.js v$NODE_VERSION..."
nvm install "$NODE_VERSION"
nvm alias default "$NODE_VERSION"

# Verify Node.js and npm
echo -n "Node.js version: "
node -v
echo -n "Current NVM alias: "
nvm current

# Pnpm
npm install -g pnpm
echo -n "pnpm version: "
pnpm -v

# Yarn
npm install -g yarn
echo -n "yarn version: "
yarn -v

# Yarn remove telemetry from yarn
yarn config set --home enableTelemetry 0

printf "\nAll done! Node.js, npm, yarn, and pnpm are now installed and configured.\n"
