#!/bin/bash

subproject=$1
mainPathDir=~/kubide/Lugfy

if [ -n "$subproject"]
	cd ${mainPathDir}
	case "$subproject" in
		"crm")
			cd ./crm
			bash autocommit.sh shared
			bash webapp_run.sh;;
		"drivers")
			cd ./drivers-app
			bash autocommit.sh shared
			bash mobile_run.sh;;
		"users")
			cd ./users-app
			bash autocommit.sh shared
 			bash mobile_run.sh;;
		"webapp")
			cd ./webapp
			bash autocommit.sh shared
			bash mobile_run.sh;;
		*)
			 echo "Subproject not found. Skipping git auto-commit..."
			 echo "Openning main directory ..."
			 code .;;
	esac
fi
