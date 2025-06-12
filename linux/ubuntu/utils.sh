#!/bin/bash

is_installed() {
  dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "install ok installed"
}

install_packages() {
  local packages=("$@")
  local to_install=()

  # Missing packages
  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  # Update Once, Install others
  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Updating package lists…"
    sudo apt-get update -qq

    echo "Installing: ${to_install[*]}"
    sudo apt-get install -y "${to_install[@]}"
  else
    echo "All requested packages are already installed."
  fi
}
