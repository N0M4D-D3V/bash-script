#!/bin/bash
#
#       Script for SSL local generation on linux systems
#
#       version: 0.0.1
#       author: N0M4D

echo '<>---< SSL Local Generator >---<>'
echo '         ---< 0.0.1 >---         '
echo '         ---< N0M4D >---         '
echo ''

echo '<!> Checking updates ...'
echo ''

sudo apt update
sudo apt upgrade

echo ''
echo '<!> Downloading mkcert from the official repo ...'
echo ''

wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64

echo ''
echo '<!> Renaming downloaded file ...'
echo ''

mv mkcert-v1.4.3-linux-amd64 mkcert

echo ''
echo '<!> Giving +x permissions to mkcert ...'
echo ''

chmod +x mkcert

echo ''
echo '<!> Moving mkcert to bin directory ...'
echo ''

sudo mv mkcert /usr/local/bin/

echo ''
echo '<!> Installing root certificate ...'
echo ''

mkcert -install

echo ''
echo '<!> Generating certs for localhost and local IPs'
echo ''

mkcert localhost 127.0.0.1 ::1
