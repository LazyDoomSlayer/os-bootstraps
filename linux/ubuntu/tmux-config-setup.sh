#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: tmux-config-setup.sh
# Purpose: Clone and apply tmux config from GitHub
# Usage: ./tmux-config-setup.sh
# ----------------------------------------------------------------------------

echo "Setting up tmux configuration..."

for cmd in git tmux; do
  command -v "$cmd" >/dev/null || {
    echo "$cmd is not installed."
    exit 1
  }
done

CLONE_DIR="$(mktemp -d)"
git clone --depth=1 https://github.com/LazyDoomSlayer/tmux-configuration.git "$CLONE_DIR"

# Note: File in repo is tmux.conf ( with no dot )
cp "$CLONE_DIR/tmux.conf" "$HOME/.tmux.conf"
echo "Copied .tmux.conf to ~"

if tmux ls &>/dev/null; then
  tmux source-file "$HOME/.tmux.conf"
  echo "Reloaded tmux config in active session"
else
  echo "No tmux session detected. Config will apply on next start."
fi

rm -rf "$CLONE_DIR"

echo "Cleanup complete"
