#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: python-setup.sh
# Purpose: Installs pipx and ruff for python development.
# Usage: ./python-setup.sh
# ----------------------------------------------------------------------------

sudo apt install pipx
pipx ensurepath

# Optional Setup
sudo pipx ensurepath --global

# Installs ruff
pipx install ruff
