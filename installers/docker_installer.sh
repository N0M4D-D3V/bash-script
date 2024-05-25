#!/bin/bash
#
# Basic script 4 docker instalation in Ubuntu Linux Systems
# 
# version: 0.0.1
# author: N0M4D

echo '<>---< DOCKER UBUNTU INSTALLER >---<>'
echo '         <>---< 0.0.1 >---<>         '
echo '         <>---< N0M4D >---<>         '
echo ''

# Uninstall old versions and unofficial packages
echo '<!> Uninstalling old versions and unofficial packages ...'
echo ''

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
echo '<!> Adding dockers official GPG key ...'
echo ''

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo '<!> Adding the repo to APT sources ...'
echo ''

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker latest version
echo '<!> Installing docker latest version ...'
echo ''

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
