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

  if [ ${#APT_QUEUE[@]} -gt 0 ]; then
    echo "Updating apt package lists..."
    sudo apt-get update -qq
    echo "Installing APT packages: ${APT_QUEUE[*]}"
    sudo apt-get install -y "${APT_QUEUE[@]}"
  else
    echo "No APT packages to install."
  fi
}

install_snap_packages() {
  local pkgs=("$@")
  local to_install=()

  for pkg in "${pkgs[@]}"; do
    if ! is_installed_snap "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -gt 0 ]; then
    for snap_pkg in "${to_install[@]}"; do
      echo "Installing snap package: $snap_pkg"
      if ! sudo snap install --classic "$snap_pkg"; then
        sudo snap install "$snap_pkg"
      fi
    done
  else
    echo "All Snap packages are already installed: ${pkgs[*]}"
  fi
}
