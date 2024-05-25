#!/bin/bash
#       This script can be used to configure the firewall of an Ubuntu (Linux) OS.
#
#       version: 0.0.1
#       author: N0M4D

echo '<>---< UBUNTU FIREWALL CONFIGURATOR >---<>'
echo ''
echo '              ---< 0.0.1 >---             '
echo '              ---< N0M4D >---             '
echo ''

echo ''
echo '<!> Verifying UFW status ...'

sudo ufw status

echo ''
echo '<!> Enabling UFW status...'

sudo ufw enable

echo ''
echo '<!> Opennings ports 80(HTTP), 443(HTTPS), 22(SSH) ...'
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp

echo ''
echo '<!> Verifying UFW status ...'
sudo ufw status
