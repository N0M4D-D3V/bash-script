#!/bin/bash
# <>-< 3.0.3 >-<>
# <>-< N0M4D >-<>
#
# For better usage, follow these steps:
#   > Grant execution permissions to the script using 'chmod +x ~/path-to-script/open-project.sh'
#   > Add the folder where you store your scripts to the PATH by including 'export PATH="path-to-scripts:$PATH"' in your .zshrc file
#   > Include the following alias in your .zshrc: open(){ . open-project.sh } and refresh your terminal
#   > Use the 'open' command to run the script without any parameters.
#
# Usage:
#   > open -> Lists projects and asks the user to select which ones to open.
#   > open project1 project2 -> Opens the specified projects directly.
#

base_dir="$HOME/Documents/projects"

echo '<>---> PROJECT OPENER SCRIPT <---<>' 
echo ''

# Function to open projects by name
open_projects_by_name() {
    for project_name in "$@"; do
        # Search for the project directory
        dir_path=$(find "$base_dir" -maxdepth 1 -type d -name "$project_name" -print -quit)
        
        if [ -n "$dir_path" ]; then
            echo " > Opening '$dir_path' ..."
            code "$dir_path"
        else
            echo " <!> Project '$project_name' not found in '$base_dir' <!>"
        fi
    done
}

# If parameters are passed, try to open the specified projects
if [ $# -gt 0 ]; then
    echo " > Opening specified projects..."
    open_projects_by_name "$@"

# If no parameters are passed, list directories and ask for user input
else
    echo " > Listing available directories:"
    echo ''

    projects=()
    index=1

    # Store the directories in an array, excluding the base directory itself, and show them with an index
    while IFS= read -r -d '' dir; do
        dir_name=$(basename "$dir")
        
        # Exclude the root directory (projects) from the list
        if [ "$dir_name" != "$(basename "$base_dir")" ]; then
            projects+=("$dir")
            echo "    [$index] $dir_name"
            index=$((index+1))
        fi
    done < <(find "$base_dir" -mindepth 1 -maxdepth 1 -type d -print0)

    # Ask the user which projects to open
    echo ''
    echo -n " > Enter the number(s) of the project(s) to open (separated by commas for multiple): "
    read input

    # Split the input by commas and remove any extra spaces
    IFS=',' read -rA indices <<< "$input"

    # Iterate over the indices provided by the user
    for i in "${indices[@]}"; do
        i=$(echo "$i" | xargs)  # Remove whitespace
        if [[ "$i" =~ ^[0-9]+$ ]] && [ "$i" -ge 1 ] && [ "$i" -le "${#projects[@]}" ]; then
            project_dir="${projects[$((i-1))]}"
            echo " > Opening '$project_dir' ..."
            code "$project_dir"
        else
            echo " <!> Index '$i' not valid. Out of range or incorrect input <!>"
        fi
    done
fi
