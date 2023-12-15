#!/bin/bash
# <>-< 2.0.0 >-<>
# <>-< N0M4D >-<>
#
# For a better use of the script, follow these steps:
#	> Grant execution permissions to the script using the command 'chmod +x ~/path-to-script/open-project.sh'
#       > Add the folder where you store your scripts to the path by including 'export PATH="path-to-scripts:$PATH"' in your .zshrc file
#	> Include the following alias in your .zshrc file: open(){ . open-project.sh $@ } and refresh your terminal
#       > Use as 'open project1 project2 project3 ...' command.
#
# Use
#   > open-project.sh [projectnames] -> open the list of projects in diferent vscode windows.
#   > open-project.sh -> show available folders under base_dir
#   > open-project.sh <number> -> show available forlders under base_dir n levels deep.



base_dir="$HOME/Documents/projects"

echo '<>---> PROJECT OPENER SCRIPT <---<>'
echo ''

# If no param is provided, list main folders in the base directory
if [ $# -eq 0 ]; then
	echo " > No params provided."
	echo " > Listing available directories at level 0 ..."
	echo ''

  	ls -d "$base_dir"/*/ | while read -r dir; do
  		echo "    - $(basename "$dir")"
  	done
fi

# If a number is passed as a parameter, list directories up to that level
if [ $# -eq 1 ] && [ $1 -eq $1 2>/dev/null ]; then
	max_depth=$1
	echo " > Depth level provided."
	echo " > Listing available directories at level $max_depth ..."
	echo ""

  	find "$base_dir" -maxdepth $max_depth -type d -exec sh -c 'echo "    - " "$(basename "$0")"' {} \;
else

  # iterate all the provided params
  for dir_to_open in "$@"
  do
	# search the directory
	echo " > Searching '$dir_to_open' ..."
	
	dir_path=$(find "$base_dir" -type d -name "$dir_to_open" -print -quit)

	# check if directory was found
	if [ -n "$dir_path" ];then
		  # open the directory
		  echo " > Starting '$dir_path' ..."
		  code "$dir_path"
	else
		  echo " <!> Directory '$dir_to_open' not found at '$base_dir' <!>"
	fi
  done
fi

