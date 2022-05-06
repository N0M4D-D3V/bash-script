#!/bin/bash
#Coded by +.N0M4D.+
#Type 'autocommit.sh help' 4 help >:v

commitMessage=${1:-"<> autocommit.sh <>"}
option=$2
OPEN_COLOR='\033[1;35m'
CLOSE_COLOR='\033[0m'
SCRIPT_VERSION='v4.3'

interfacesPath=./src/shared

currentBranch=`git branch --show-current`
currentBranchName=$currentBranch
masterBranchName='main'
developBranchName='develop'

function _check_dependencies () {
    command -v git >/dev/null 2>&1 || { echo >&2 "GIT not installed. Aborting..."; exit 1; }
    command -v figlet >/dev/null 2>&1 || { echo >&2 "FIGLET not installed. You should install 4 better experience!";}
}

function _git_update () {
    git status
    git add .
    git commit -m "$commitMessage"
    git pull origin $masterBranchName
    git pull origin $developBranchName
}

function _git_push () {
    git push origin $masterBranchName
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
    echo '   autocommit.sh [message] [option]'
    echo '   examples:'
    echo -e "      > autocommit.sh\n      < autocommit.sh 'initial commit' none\n      > autocommit.sh 'shared commit' onlyshared\n"
    _print_with_color '<> PARAMS <>' 0.5
    echo '   - Options'
    echo '      > none: pull/push only in current branch.'
    echo '      < shared: pull/push in current branch and shared repos.'
    echo '      > onlyshared: pull/push only in shared repos.'
    echo '      < help: shows help'
    echo ''
    echo -e "   - Message: adds custom message to all commits\n"
    _print_with_color '<> CUSTOMIZATION <>' 0.5
    echo '   You can change the master/devel branch name by only changing the variables at the top of the script. You can change the shared submodules directory too.'
    echo '   Pushing to master/develop branch is blocked.'
    echo -e "\nWARNING: < git add . > command will be executed at runtime! Take care of it..."
}

function _return_dir () {
    for ((i = 0 ; i < ${1:-1} ; i++)); do
        cd ..
    done
}

function _update_shared(){
    _print_with_color "<>---<> UPDATING SHARED <>---<>"
	cd ./src/shared
	
    #updates shared/interfaces
	cd ./interfaces
	_git_update
    _git_push
    _return_dir
	
    #updates shared/services
	cd ./services
	_git_update
    _git_push
	_print_with_color "\n<> INTERFACES & SERVICES UDATED <>" 2
    _return_dir 3
}

#######################################
############## 3X3KUT10N ##############
#######################################

_check_dependencies
if [[ "$option" =~ "help" ]] || [[ "$commitMessage" =~ "help" ]];
then
    _print_help
    exit 0
fi

_print_title "4UT0C0MM1T"
_print_with_color "<>---<> INITIALIZING AUTOCOMMIT BASH SCRIPT ${SCRIPT_VERSION} <>---<>"

# updates shared repositories if $option contains "shared" substring.
if [[ "$option" =~ "shared" ]]
then
    _update_shared
fi

#Updates current branch from master && develop unless $option == "onlyshared"
if [ "$option" != "onlyshared" ]
then
    _print_with_color "<> UPDATING MAIN PROJECT <>"
    _git_update

    #If current branch is not master or develop, push
    if [ $currentBranchName != $masterBranchName ] && [ $currentBranchName != developBranchName ];
    then
        git push origin $currentBranch
    fi
fi

_print_title "UPD4T3D =)"
