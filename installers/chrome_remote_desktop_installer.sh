#!/bin/zsh
# 
# version: 0.0.1
# author: N0M4D

echo '<>---< CHROME REMOTE DESKTOP INSTALLER >---<>'
echo '             <>---< 0.0.1 >---<>             '
echo '             <>---< N0M4D >---<>             '
echo ''

sudo apt update && sudo apt upgrade

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt-get install --assume-yes ./chrome-remote-desktop_current_amd64.deb

sudo apt install slim -y
sudo apt install ubuntu-desktop -y

sudo reboot

sudo service slim start

# https://medium.com/@selvamraju007/install-and-launch-ubuntu-22-04-desktop-on-google-cloud-1fba8c0f9585