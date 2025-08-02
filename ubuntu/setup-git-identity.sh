#!/bin/bash
set -euo pipefail

source ./utils.sh

# ── Load environment variables ───────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/.env" ]; then
  # export all variables declared in .env
  set -a
  source "$SCRIPT_DIR/.env"
  set +a
else
  error ".env not found in $SCRIPT_DIR, aborting."
  exit 1
fi

# ── Helper function to configure a Git repo ─────────
configure_repo() {
  local repo_path="$1"
  local name="$2"
  local email="$3"
  local key="$4"

  log "Configuring $repo_path"
  git -C "$repo_path" config --local user.name "$name"
  git -C "$repo_path" config --local user.email "$email"
  git -C "$repo_path" config --local core.sshCommand "ssh -i ${key/#\~/$HOME}"
}

# ── Walk through repo folders ───────────────────

# Personal GitHub
for dir in "${GH_PERSONAL_ROOT/#\~/$HOME}"/*; do
  if [ -d "$dir/.git" ]; then
    configure_repo "$dir" "$PERSONAL_NAME" "$PERSONAL_EMAIL" "$PERSONAL_SSH_KEY"
  fi
done

# Work GitHub
for dir in "${GH_WORK_ROOT/#\~/$HOME}"/*; do
  if [ -d "$dir/.git" ]; then
    configure_repo "$dir" "$WORKGH_NAME" "$WORKGH_EMAIL" "$WORKGH_SSH_KEY"
  fi
done

# Bitbucket
for dir in "${BB_ROOT/#\~/$HOME}"/*; do
  if [ -d "$dir/.git" ]; then
    configure_repo "$dir" "$WORKBB_NAME" "$WORKBB_EMAIL" "$WORKBB_SSH_KEY"
  fi
done

success "All matching repos configured."
