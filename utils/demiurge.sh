#!/bin/bash
# <>-< 3.1.1 >-<>
# <>-< N0M4D >-<>
#
# To better use this script, follow these steps:
#   > Give execution permissions using 'chmod +x ~/path-to-script/open-project.sh'
#   > Add the folder where you store your scripts to the PATH with 'export PATH="path-to-scripts:$PATH"' in your .zshrc
#   > Add the following alias in your .zshrc: open(){ . open-project.sh } and refresh your terminal
#   > Use the command 'open' to run the script with or without parameters.
#
# Usage
#   > open -> Lists the projects and asks the user which one(s) to open.
#   > open project1 project2 ... -> Opens the specified projects directly.
#

base_dir="$HOME/Documents/projects"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}<>---< D3M1URG3 >---<>${NC}"
echo ''

# If parameters are passed, open the specified projects directly
if [ $# -gt 0 ]; then
    for dir_to_open in "$@"; do
        echo -e " > Searching for '$dir_to_open' ..."

        dir_path=$(find "$base_dir" -type d -name "$dir_to_open" -print -quit)

        if [ -n "$dir_path" ]; then
            echo -e " > Opening '$dir_path' ..."
            code "$dir_path"
        else
            echo -e "${RED} <!> Directory '$dir_to_open' not found in '$base_dir' <!>${NC}"
        fi
    done

# If no parameters are provided, list the directories in base_dir and ask the user to choose
else

    echo " > Listing available directories:"
    echo ''

    projects=()
    index=0

    # Store directories in an array and display them with an index
    while IFS= read -r -d '' dir; do
        dir_name=$(basename "$dir")
        projects+=("$dir")
        echo "    [$index] $dir_name"
        index=$((index+1))
    done < <(find "$base_dir" -maxdepth 1 -type d -print0)

    # Ask the user which projects to open
    echo ''
    echo -n -e "${GREEN} > Enter the number of the project(s) to open (comma-separated): ${NC}"
    read input

    # Split input by commas and trim spaces
    IFS=',' read -r -a indices <<< "$input"

    # Iterate over the provided indices and open the corresponding projects
    for i in "${indices[@]}"; do
        i=$(echo "$i" | xargs)  # Remove leading/trailing spaces
        if [[ "$i" =~ ^[0-9]+$ ]] && [ "$i" -ge 1 ] && [ "$i" -le "${#projects[@]}" ]; then
            project_dir="${projects[$((i))]}"
            echo " > Opening '$project_dir' ..."
            code "$project_dir"
        else
            echo -e "${RED} <!> Index '$i' not valid. Out of range or incorrect input <!>${NC}"
        fi
    done
fi
