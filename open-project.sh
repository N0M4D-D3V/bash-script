#!/bin/bash
# open-project.sh [params]
#
# <> Coded by N0M4D <>
# 
#
# For a better use of the script, follow these steps:
#	> Grant execution permissions to the script using the command 'chmod +x ~/path-to-script/open-project.sh'
#       > Add the folder where you store your scripts to the path by including 'export PATH="path-to-scripts:$PATH"' in your .zshrc file
#	> Include the following alias in your .zshrc file: open(){ . open-project.sh $@ } and refresh your terminal
#       > Use as 'open project1 project2 project3 ...' command.



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
