#!/bin/bash
# buildprod.sh [params] 
#Coded by N0M4D

base_dir="$HOME/Documents/Projects"

# Checks if a directory name is provided as param
if [ $# -eq 0 ]; then
	echo "Please, pass a directory name as param"
	exit 1
fi

# iterate all the provided params
for dir_to_open in "$@"
do
	# search the directory
	echo "Searching '$dir_to_open' ..."
	dir_path=$(find "$base_dir" -type d -name "$dir_to_open" -print -quit)

	# check if directory was found
	if [ -n "$dir_path" ];then
		# open the directory
		echo "Starting '$dir_to_open' ..."
		code "$dir_path"
	else
		echo "Directory '$dir_to_open' not found at '$base_dir'."
	fi
done
