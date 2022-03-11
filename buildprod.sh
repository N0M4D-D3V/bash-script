#!/bin/bash

OPN_COLOR='\e[1;35m'
CLS_COLOR='\e[0m'

function _print_title(){
    echo -e "$OPN_COLOR"
    figlet -f letter $1
    echo -e "$CLS_COLOR"
    sleep ${2:-1}
}

_print_title "BU1LDPR0D v1.3" 2

bash autocommit.sh shared "buildprod.sh script - beforelinter"

_print_title "L1NT3R" 2
npm run prestart

bash autocommit.sh shared "buildprod.sh script - afterlinter"

_print_title "BUILD:PROD" 2
npm run build:prod

_print_title "D0N3 =)" 2
