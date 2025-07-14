#!/bin/bash

is_installed_apt() {
  dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "install ok installed"
}

is_installed_snap() {
  snap list "$1" &>/dev/null
}

install_apt_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed_apt "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -gt 0 ]; then
    log "Updating apt package lists..."
    sudo apt-get update -qq
    log "Installing APT packages: ${to_install[*]} 📦"
    sudo apt-get install -y "${to_install[@]}"
  else
    warn "No APT packages to install."
  fi
}

install_snap_packages() {
  if ! command -v snap &>/dev/null; then
    warn "Snap is not installed. Skipping Snap package installation."
    return
  fi

  local pkgs=("$@")
  local to_install=()

  for pkg in "${pkgs[@]}"; do
    if ! is_installed_snap "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -eq 0 ]; then
    success "All Snap packages are already installed: ${pkgs[*]}"
    return
  fi

  log "Installing Snap packages: ${to_install[*]}"
  for snap_pkg in "${to_install[@]}"; do
    log "Installing: $snap_pkg 📦"
    if sudo snap install "$snap_pkg"; then
      success "Installed (normal): $snap_pkg"
    elif sudo snap install --classic "$snap_pkg"; then
      success "Installed (classic): $snap_pkg"
    else
      error "Failed to install: $snap_pkg"
    fi
  done
}

die() {
  error "$*"
  exit 1
}

run_script() {
  local path="$1"

  [[ -f "$path" ]] || die "Script not found: $path"

  log "Preparing $(basename "$path")"
  chmod +x "$path"
  log "Running $(basename "$path")"
  "$path"
  success "$(basename "$path") completed"
}

log() { printf "\033[1;34m[ℹ️ INFO]: %s\033[0m\n\n" "$1"; }
success() { printf "\033[1;32m[✅ SUCCESS]: %s\033[0m\n\n" "$1"; }
warn() { printf "\033[1;33m[⚠️ WARN]: %s\033[0m\n\n" "$1"; }
error() { printf "\033[1;31m[❌ ERROR]: %s\033[0m\n\n" "$1"; }
