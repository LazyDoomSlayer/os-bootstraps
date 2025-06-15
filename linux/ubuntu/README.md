# Ubuntu Bootstrap Scripts

These scripts automate the setup of a full-featured development environment on a fresh Ubuntu machine.

## 🔧 Scripts Overview

- `run.sh` – Master script that runs everything in order.
- `utils.sh` – Shared helper functions, especially for package installation.
- `packages.conf` – Contains arrays of packages to be installed (APT/SNAP).
- `docker-setup.sh` – Installs Docker and sets up the Docker group.
- `lazygit-setup.sh` – Installs the `lazygit` TUI Git client.
- `node-setup.sh` – Installs Node.js (via NodeSource or preferred method).
- `python-setup.sh` – Sets up Python tools and virtualenv.
- `zoxide-setup.sh` – Installs `zoxide`, a smarter `cd` command replacement.
- `tmux-config-setup.sh` – Applies a Tmux configuration.
- `tpm-setup.sh` – Installs the Tmux Plugin Manager (TPM).

## 📦 Configuration

All APT and SNAP packages are listed in `packages.conf`. You can modify this file to suit your environment:

```bash
SYSTEM_UTILS_APT=(curl wget git ...)
DEV_TOOLS_APT=(build-essential cmake ...)
````

## 🚀 Running the Setup

Make sure the script is executable:

```bash
chmod +x run.sh
./run.sh
```

This will:

1. Print a logo.
2. Source `packages.conf` and `utils.sh`.
3. Update the system.
4. Install the packages.
5. Set up Docker, Node.js, Python, Zoxide.
6. Configure tmux and TPM.

## 🔒 Notes

* Some installations may prompt for `sudo` access.
* You may want to reboot after installation for group memberships (e.g., Docker) to take effect.

## 💡 Customize

Feel free to:

* Add/remove packages in `packages.conf`
* Add custom dotfiles or shell setup steps
* Fork the repo and adapt it to other distros

