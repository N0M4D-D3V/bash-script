#!/bin/bash

subproject=$1
mainDirPath=~/kubide/HappyGift

cd $mainDirPath
if [ -n "$subproject" ]
then
	case "$subproject" in
		"webapp") 
			cd ./webapp
			bash autocommit.sh shared
			bash webapp_run.sh;;
			
		"mobileapp") 
			cd ./mobileapp
			bash autocommit.sh shared
			bash mobile_run.sh;;
			
		*) 
			echo "Subproject not found. Skipping git auto-commit ..."
			echo "Openning main folder ..."
			code .;;
	esac
fi
