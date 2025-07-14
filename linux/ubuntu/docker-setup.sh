#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------------
# Script: docker-setup.sh
# Purpose: Installs Docker Engine and Docker Compose plugin with informative output.
# Usage: ./docker-setup.sh
# ----------------------------------------------------------------------------

source ../utils.sh

log "Starting Docker installation..."

log "Updating package database..."
sudo apt-get update

log "Installing prerequisites (ca-certificates, curl, gnupg)..."
sudo apt-get install -y ca-certificates curl gnupg

log "Creating directory for Docker GPG keyrings..."
sudo install -m 0755 -d /etc/apt/keyrings

log "Fetching Docker's official GPG key..."
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

log "Adding Docker repository to APT sources..."
ARCH=$(dpkg --print-architecture)
UBUNTU_CODENAME=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
echo \
  "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  ${UBUNTU_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

log "Updating package database with Docker packages..."
sudo apt-get update

log "Installing Docker Engine, CLI, containerd, Buildx, and Compose plugin..."
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

log "Verifying Docker installation..."
sudo docker --version
sudo docker compose version

success "Docker setup complete!"
