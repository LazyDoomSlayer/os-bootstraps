#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: tmux-config-setup.sh
# Purpose: Clone and apply tmux config from GitHub
# Usage: ./tmux-config-setup.sh
# ----------------------------------------------------------------------------

source ./utils.sh

log "Setting up tmux configuration..."

# Ensure required commands are available
for cmd in git tmux; do
  if ! command -v "$cmd" &>/dev/null; then
    error "$cmd is not installed. Aborting."
    exit 1
  fi
done

CLONE_DIR="$(mktemp -d)"
log "Cloning LazyDoomSlayer/tmux-configuration repo..."
git clone --depth=1 https://github.com/LazyDoomSlayer/tmux-configuration.git "$CLONE_DIR"

log "Copying tmux.conf to ~/.tmux.conf"
cp "$CLONE_DIR/tmux.conf" "$HOME/.tmux.conf"
success "Copied tmux config to ~/.tmux.conf"

# Apply config if tmux session is running
if tmux ls &>/dev/null; then
  log "Detected active tmux session. Reloading config..."
  tmux source-file "$HOME/.tmux.conf"
  success "tmux config reloaded in active session"
else
  warn "No tmux session detected. Config will apply on next start."
fi

log "Cleaning up temporary clone directory..."
rm -rf "$CLONE_DIR"
success "Cleanup complete"
