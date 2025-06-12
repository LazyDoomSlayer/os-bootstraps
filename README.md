# What things i need to automate


## Update and Upgrade running

``` Initially
sudo apt-get update -y && sudo apt-get upgrade -y
```

``` Install Curl & Wget for packages to download
sudo apt install curl -y & sudo apt install wget -y
```



## dev packages to install 
```
neovim
btop
yazi
fzf

tmux
tmux (tpm)
git
```


## Install docker


```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get Update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

## Tools to install
```
sudo apt install zoxide -y
ZOX_LINE='eval "$(zoxide init bash)"'

#!/bin/bash

# Install zoxide
echo "Installing zoxide..."
sudo apt update && sudo apt install -y zoxide

# Zoxide init line
ZOX_LINE='eval "$(zoxide init bash)"'

# Add to ~/.bashrc if not already there
if ! grep -Fxq "$ZOX_LINE" ~/.bashrc; then
  echo "Adding zoxide init to ~/.bashrc..."
  echo "" >> ~/.bashrc
  echo "# Initialize zoxide" >> ~/.bashrc
  echo "$ZOX_LINE" >> ~/.bashrc
else
  echo "zoxide init already present in ~/.bashrc"
fi

# Reload ~/.bashrc
echo "Reloading ~/.bashrc..."
source ~/.bashrc

echo "zoxide setup complete."

```


## lazygit install

``` Ubuntu before 25 version
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
rm -rf lazygit.tar.gz 
rm -rf tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
```

### We need to install ruff for python

``` ubuntu installation guide
sudo apt update
sudo apt install pipx
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
```

``` fedora installation guide
sudo dnf install pipx
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
```


``` Install ruff itself.
pipx install ruff
```



