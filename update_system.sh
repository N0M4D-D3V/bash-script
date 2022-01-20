#!/bin/bash

bash titleprinter.sh "M41nt3n4nc3" 2

apt-get update
apt-get -y upgrade
apt-get -y autoremove
apt-get autoclean

bash titleprinter.sh "Syst3m Cl34r"
