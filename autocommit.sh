#!/bin/bash

updateShared=$1
commitMessage=${2:-"script - autocommit"}
OPEN_COLOR='\e[1;35m'
CLOSE_COLOR='\e[0m'

interfacesPath=./src/shared

currentBranch=`git branch --show-current`

echo -e "\n$OPEN_COLOR"
figlet -f letter "4UT0C0MM1T"
sleep 0.5
echo -e " <>---<> INITIALIZING AUTOCOMMIT BASH SCRIPT v1.1 <>---<>\n $CLOSE_COLOR"
sleep 1

if [ -n "$updateShared" ]
then
	echo -e "$OPEN_COLOR\n <>---<> Updating shared <>---<>$CLOSE_COLOR"
	sleep 1
	echo -e "${OPEN_COLOR}finding /src/shared $CLOSE_COLOR"
	cd ./src/shared
	
	echo -e "${OPEN_COLOR}updating interfaces ...\n $CLOSE_COLOR"
	cd ./interfaces
	git status
	git add .
	git commit -m "$commitMessage"
	git pull origin master
	git push origin master
	echo -e "${OPEN_COLOR}return to ./shared $CLOSE_COLOR"
	cd ..
	
	echo -e "${OPEN_COLOR}updating services ...\n $CLOSE_COLOR"
	cd ./services
	git status
	git add .
	git commit -m "$commitMessage"
	git pull origin master
	git push origin master
	echo -e "${OPEN_COLOR}\n <> INTERFACES & SERVICES UDATED <> $CLOSE_COLOR"
	echo -e "${OPEN_COLOR}returning to main folder\n $CLOSE_COLOR"
	cd ..
	cd ..
	cd ..
	
fi

echo -e "${OPEN_COLOR}<>---<> Updating main project <>---<>\n$CLOSE_COLOR"
sleep 1
git status
git add .
git commit -m "$commitMessage"
git pull origin master

test=$currentBranch
if [ $test != "master" ]
then
    echo "i am in master"
    git push origin $currentBranch
fi

echo -e "$OPEN_COLOR"
figlet -f letter "UPD4T3D =)"
echo -e "$CLOSE_COLOR"
