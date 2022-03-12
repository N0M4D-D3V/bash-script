#!/bin/bash
#coded by +\N0M4D/+
OPN_COLOR='\e[1;35m'
CLOSE_COLOR='\e[0m'

function _print_title () {
    echo -e "$OPN_COLOR"
    figlet -f letter $1
    echo -e "$CLOSE_COLOR"
    sleep ${2:-1}
}

_print_title "M41nt3n4nc3" 2

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
sudo apt-get autoclean

_print_title "Syst3m Cl34r"
