#!/bin/bash
# <>-< 4.0.0 >-<>
# <>-< N0M4D >-<>
#
# To use this script effectively, follow these steps:
#   > Grant execution permissions with: 'chmod +x ~/path-to-script/open-project.sh'
#   > Add the folder where you store your scripts to your PATH by adding 'export PATH="path-to-scripts:$PATH"' to your .zshrc or .bashrc file.
#   > Create an alias in your .zshrc or .bashrc like: 'alias open=". open-project.sh"' and refresh your terminal.
#   > Use the command 'open' to run the script with or without parameters.
#
# Usage:
#   > open -> Lists available projects and prompts the user to choose which one(s) to open.
#   > open project1 project2 ... -> Opens the specified projects directly.
#
# Key Bindings (when selecting projects):
#   > Arrow Up: Move cursor up.
#   > Arrow Down: Move cursor down.
#   > Arrow Right: Select the project at the current cursor position.
#   > Arrow Left: Deselect the project at the current cursor position.
#

base_dir="$HOME/Documents/projects"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[34m'
NC='\033[0m' # No Color

index=0
projects=()
project_names=()

cursor_index=0
is_selection_running=true

selected_project_indexes=()

# Function to handle arrow key detection
detect_keys() {
  while $is_selection_running; do
    list_directories
    # Read a single key press
    IFS= read -rsn1 key  # Read first character of the key press
    
    if [[ -z "$key" ]]; then
        is_selection_running=false

    elif [[ $key == $'\e' ]]; then
      # Detect if it's an escape sequence (arrow keys start with \e)
      IFS= read -rsn2 -t 0.1 key  # Read the next two characters
      case "$key" in
        "[A") go_up;;
        "[B") go_down;;
        "[C") go_right;;
        "[D") go_left;;
      esac
    fi
  done
}

go_up() {
    # Get the length of the array
    len=${#projects[@]}
    len=$((len - 1))

    if [ "$cursor_index" -gt 0 ]; then
        cursor_index=$((cursor_index-1))
    else
        cursor_index=$((len))
    fi
}

go_down() {
    # Get the length of the array
    len=${#projects[@]}
    len=$((len - 1))

    if [ "$cursor_index" -lt "$len" ]; then
        cursor_index=$((cursor_index+1))
    else
        cursor_index=0
    fi
}

go_right() {
    if is_in_array "$cursor_index" "${selected_project_indexes[@]}"; then
        # if is in array do nothing
        echo ""
    else
        selected_project_indexes+=("$cursor_index")
    fi
}

go_left() {
    if is_in_array "$cursor_index" "${selected_project_indexes[@]}"; then
        selected_project_indexes=($(remove_from_array "$cursor_index" "${selected_project_indexes[@]}"))
    fi
}

# Function to check if a number is in the array
is_in_array() {
  local number=$1
  shift
  local array=("$@")

  for num in "${array[@]}"; do
    if [[ "$num" -eq "$number" ]]; then
      return 0  # Return 0 if the number is found
    fi
  done

  return 1  # Return 1 if the number is not found
}

# Function to remove a number from an array if it exists
remove_from_array() {
  local number=$1
  shift
  local array=("$@")
  local new_array=()

  for num in "${array[@]}"; do
    if [[ "$num" -ne "$number" ]]; then
      new_array+=("$num")  # Add to new array if it's not the number to remove
    fi
  done

  # Return the new array
  echo "${new_array[@]}"
}

# Function to find and list available projects
find_available_projects() {
    clear

    echo ''
    echo " > Looking for available projects ..."
    echo ''

    # Store directories in an array and display them with an index
    while IFS= read -r -d '' dir; do
        dir_name=$(basename "$dir")
        projects+=("$dir")
        project_names+=("$dir_name")
    done < <(find "$base_dir" -maxdepth 1 -type d -print0)
}

# Function to list directories with current selection highlighted
list_directories() {
    clear
    index=0

    echo ''
    echo " > Listing available projects:"
    echo ''

    for dir_name in "${project_names[@]}"; do
        if [[ $cursor_index == $index ]]; then
            echo -e "${BLUE}    [${index}] $dir_name ${NC}"

        elif is_in_array "$index" "${selected_project_indexes[@]}"; then
            echo -e "${GREEN}    [${index}] $dir_name ${NC}"
        else
            echo "    [${index}] ${dir_name}"
        fi

        index=$((index+1))
    done
}

# Function to open projects by index
openProjectsByIndex() {
    echo ""

    # Iterate over the provided indices and open the corresponding projects
    for i in "${selected_project_indexes[@]}"; do
        i=$(echo "$i" | xargs)  # Remove leading/trailing spaces

        if ! [[ "$i" =~ ^[0-9]+$ ]]; then
            echo -e "${RED} <!> '$i' is not a valid number. Skipping... <!>${NC}"
            continue
        fi

        if [[ "$i" =~ ^[0-9]+$ ]] && [ "$i" -ge 0 ] && [ "$i" -le "${#projects[@]}" ]; then
            project_dir="${projects[$((i))]}"
            echo " > Opening '$project_dir' ..."
            code "$project_dir"
        else
            echo -e "${RED} <!> Index '$i' not valid. Out of range or incorrect input <!>${NC}"
        fi
    done
}

# Function to open projects by name
openProjectsByName() {
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
}


# Main script logic
if [ $# -gt 0 ]; then
    # If parameters are passed, open the specified projects directly
    openProjectsByName $@

else
    # If no parameters are provided, list the directories in base_dir and ask the user to choose
    find_available_projects
    detect_keys
    openProjectsByIndex
fi

clear
