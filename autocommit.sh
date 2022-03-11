#!/bin/bash
#Coded by: +.N0M4D.+

option=$1
commitMessage=${2:-"<> autocommit.sh <>"}
OPEN_COLOR='\e[1;35m'
CLOSE_COLOR='\e[0m'

interfacesPath=./src/shared

currentBranch=`git branch --show-current`
currentBranchName=$currentBranch

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
    figlet -f letter $1
    echo -e "$CLOSE_COLOR"
    sleep 0.5
}

function _print_with_color () {
    echo -e "$OPEN_COLOR $1 $CLOSE_COLOR"
    sleep ${2:-1}
}

function _print_help () {
    _print_with_color '<> USE <>'
    echo '   autocommit.sh [option] [message]'
    echo '   examples:'
    echo -e "      > autocommit.sh\n      < autocommit.sh none 'initial commit'\n      > autocommit.sh onlyshared 'shared commit'\n"
    _print_with_color '<> PARAMS <>'
    echo '   - Options'
    echo '      > none: pull/push only in current branch.'
    echo '      < shared: pull/push in current branch and shared repos.'
    echo '      > onlyshared: pull/push only in shared repos.'
    echo '      < help: shows help'
    echo ''
    echo '   - Message: adds custom message to all commits'
    exit 0

}

function _return_dir () {
    for ((i = 0 ; i < ${1:-1} ; i++)); do
        cd ..
    done
}

_print_title "4UT0C0MM1T"
_print_with_color "<>---<> INITIALIZING AUTOCOMMIT BASH SCRIPT v3.0 <>---<>"

# shows help
if [[ "$options" =~ "help" ]]
then
    _print_help
fi
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

#Updates current main branch from master unless $updateShared == "only-shared"
if [ "$option" != "onlyshared" ]
then
    #Updates current branch from master
    _print_with_color "<> UPDATING MAIN PROJECT <>"
    _git_update

    #If current branch is not master, push
    if [ $currentBranchName != "master" ]
    then
        git push origin $currentBranch
    fi
fi

_print_title "UPD4T3D =)"
