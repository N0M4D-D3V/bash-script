#!/bin/bash
#Coded by +.N0M4D.+
#Type 'autocommit.sh help' 4 help >:v

option=$1
commitMessage=${2:-"<> autocommit.sh <>"}
OPEN_COLOR='\e[1;35m'
CLOSE_COLOR='\e[0m'

interfacesPath=./src/shared

currentBranch=`git branch --show-current`
currentBranchName=$currentBranch

function _check_dependencies () {
    command -v git >/dev/null 2>&1 || { echo >&2 "GIT not installed. Aborting..."; exit 1; }
    command -v figlet >/dev/null 2>&1 || { echo >&2 "FIGLET not installed. Aborting..."; exit 1; }
}

function _git_update () {
    git status
    git add .
    git commit -m "$commitMessage"
    git pull origin master
}

function _git_push () {
    git push origin master
}

function _print_title () {
    echo -e "$OPEN_COLOR"
    figlet $1
    echo -e "$CLOSE_COLOR"
    sleep 0.5
}

function _print_with_color () {
    echo -e "$OPEN_COLOR $1 $CLOSE_COLOR"
    sleep ${2:-1}
}

function _print_help () {
    _print_with_color '<> USE <>' 0.5
    echo '   autocommit.sh [option] [message]'
    echo '   examples:'
    echo -e "      > autocommit.sh\n      < autocommit.sh none 'initial commit'\n      > autocommit.sh onlyshared 'shared commit'\n"
    _print_with_color '<> PARAMS <>' 0.5
    echo '   - Options'
    echo '      > none: pull/push only in current branch.'
    echo '      < shared: pull/push in current branch and shared repos.'
    echo '      > onlyshared: pull/push only in shared repos.'
    echo '      < help: shows help'
    echo ''
    echo '   - Message: adds custom message to all commits'
}

function _return_dir () {
    for ((i = 0 ; i < ${1:-1} ; i++)); do
        cd ..
    done
}

_check_dependencies
# shows help and exit
if [[ "$option" =~ "help" ]]
then
    _print_help
    exit 0
fi

_print_title "4UT0C0MM1T"
_print_with_color "<>---<> INITIALIZING AUTOCOMMIT BASH SCRIPT v3.1 <>---<>"

# updates shared repositories if $updateShared contains "shared" substring.
if [[ "$option" =~ "shared" ]]
then
    _print_with_color "<>---<> UPDATING SHARED <>---<>"
	cd ./src/shared
	
    #updates shared/interfaces
	_print_with_color "\nUpdating interfaces..."
	cd ./interfaces
	_git_update
    _git_push
    _return_dir
	
    #updats shared/services
	_print_with_color "\nUpdating services..."
	cd ./services
	_git_update
    _git_push
	_print_with_color "\n<> INTERFACES & SERVICES UDATED <>" 2
    _return_dir 3
	
fi

#Updates current main branch from master unless $updateShared == "onlyshared"
if [ "$option" != "onlyshared" ]
then
    #Updates current branch from master
    _print_with_color "<> UPDATING MAIN PROJECT <>"
    _git_update

    #If current branch is not master, push
    if [ $currentBranchName != "master" ] && [ $currentBranchName != "main" ] && [ $currentBranchName != "develop"];
    then
        git push origin $currentBranch
    fi
fi

_print_title "UPD4T3D =)"
