#!/bin/bash
text=$1;
debounce=${2:-1}

OPN='\e[1;35m'
STP='\e[0m'

echo -e "${OPN}"
figlet -f letter "${text}"
echo -e "${STP}"
sleep $debounce

