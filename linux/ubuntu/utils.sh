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
    echo "Updating apt package lists..."
    sudo apt-get update -qq
    echo "Installing APT packages: ${to_install[*]}"
    sudo apt-get install -y "${to_install[@]}"
  else
    echo "No APT packages to install."
  fi
}

install_snap_packages() {
  if ! command -v snap &>/dev/null; then
    echo "Snap is not installed. Skipping Snap package installation."
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
    echo "All Snap packages are already installed: ${pkgs[*]}"
    return
  fi

  echo "Installing Snap packages: ${to_install[*]}"
  for snap_pkg in "${to_install[@]}"; do
    echo "Installing: $snap_pkg"
    if sudo snap install --classic "$snap_pkg"; then
      echo "Installed (classic): $snap_pkg"
    elif sudo snap install "$snap_pkg"; then
      echo "Installed (normal): $snap_pkg"
    else
      echo "Failed to install: $snap_pkg"
    fi
  done
}
