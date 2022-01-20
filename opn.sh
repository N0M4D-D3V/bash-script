#!/bin/bash
project=$1
app=$2

OPEN_COLOR='\e[1;35m'
CLOSE_COLOR='\e[0m'

notfoundMessage="${OPEN_COLOR}\nProject param not found D:\n $CLOSE_COLOR"
noProjectnameMessage="{$OPEN_COLOR}\nProject name not found D:\n $CLOSE_COLOR"

bash titleprinter.sh "0P3N SCR1PT" 2
echo -e "${OPEN_COLOR} <>---::---<> v1.1 <>---::---<>${CLOSE_COLOR}"
if [ -n "$project" ]
then
	case "$project" in
		"happy") bash opn_happy.sh $app;;
		"excalibur") bash opn_excalibur.sh $app;;
		"lugfy")  bash opn_lugfy.sh $app;;
		"onyze")  bash opn_onyze.sh $app;;
		"retro") bash opn_retro.sh;;
        "crypt0tr4dd3r") bash opn_crypt0tr4dd3r.sh;;
        "p4rz1v4l") bash opn_p4rz1v4l.sh;;
		*) echo -e "$noProjectnameMessage";;
	esac
else
	echo -e "$notfoundMessage"
fi
