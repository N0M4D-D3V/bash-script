#!/bin/bash
#Coded by N0M4D:

OPN_COLOR='\e[1;35m'
CLS_COLOR='\e[0m'

function _print_title(){
    echo -e "$OPN_COLOR"
    figlet -f letter $1
    echo -e "$CLS_COLOR"
    sleep ${2:-2}
}

_print_title "BU1LDPR0D v1.4"

bash autocommit.sh shared "buildprod.sh script - beforelinter"

_print_title "L1NT3R"
npm run prestart

bash autocommit.sh shared "buildprod.sh script - afterlinter"

_print_title "BUILD:PROD"
npm run build:prod

_print_title "D0N3 =)"
