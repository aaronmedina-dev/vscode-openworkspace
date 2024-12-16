#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Config file path (relative to the script's directory)
CONFIG_FILE="$SCRIPT_DIR/vscode_openworkspaces.conf"

# Ensure the config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Configuration file not found: $CONFIG_FILE"
  exit 1
fi

# Load configuration (JSON-like format)
declare -A WORKSPACES
while IFS= read -r line; do
  if [[ "$line" =~ \"([^\"]+)\":\ \"([^\"]+)\" ]]; then
    key="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"
    WORKSPACES["$key"]="$value"
  fi
done < "$CONFIG_FILE"

# Check if any workspace is configured
if [[ ${#WORKSPACES[@]} -eq 0 ]]; then
  echo "No workspaces configured in $CONFIG_FILE"
  exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Collect folder options
options=()
workspace_labels=()
index=1

echo -e """${RED}
 ██╗   ██╗███████╗       ██████╗ ██╗    ██╗
 ██║   ██║██╔════╝      ██╔═══██╗██║    ██║
 ██║   ██║███████╗█████╗██║   ██║██║ █╗ ██║
 ╚██╗ ██╔╝╚════██║╚════╝██║   ██║██║███╗██║
  ╚████╔╝ ███████║      ╚██████╔╝╚███╔███╔╝
   ╚═══╝  ╚══════╝       ╚═════╝  ╚══╝╚══╝ ${RESET}v1.0
"""

for workspace in "${!WORKSPACES[@]}"; do
  workspace_dir="${WORKSPACES[$workspace]}"

  # Expand ~ in paths
  workspace_dir="${workspace_dir/#\~/$HOME}"

  # Check if the workspace directory exists
  if [[ ! -d "$workspace_dir" ]]; then
    echo -e "${RED}Workspace directory does not exist: $workspace_dir${RESET}"
    continue
  fi

  # List folders in the workspace directory
  folders=($(ls -dt "$workspace_dir"/*/ 2>/dev/null))

  # Check if any folders are found
  if [[ ${#folders[@]} -eq 0 ]]; then
    echo -e "${CYAN}No folders found in workspace: $workspace_dir${RESET}"
    continue
  fi

  # Add folders to options
  echo -e "Select a folder from ${BLUE}${workspace}${RESET} (${workspace_dir}):"
  for folder in "${folders[@]}"; do
    folder_name=$(basename "$folder")
    echo -e "[${GREEN}$index${RESET}] $folder_name"
    options+=("$folder")
    workspace_labels+=("$workspace")
    ((index++))
  done
  echo
done

# Check if there are any options to select
if [[ ${#options[@]} -eq 0 ]]; then
  echo -e "${RED}No folders found in any workspace.${RESET}"
  exit 1
fi

echo -e "${BLUE}ctrl+c to exit.${RESET}"
# Read user input
read -p "Enter the number corresponding to your choice: " choice

# Validate input
if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#options[@]} )); then
  echo -e "${RED}Invalid choice. Please enter a number between 1 and ${#options[@]}.${RESET}"
  exit 1
fi

# Get the selected folder
target_folder="${options[choice-1]}"
workspace_label="${workspace_labels[choice-1]}"

# Open the selected folder in VS Code
echo -e "${GREEN}Opening folder: ${CYAN}${target_folder}${GREEN} from workspace ${CYAN}${workspace_label}${RESET}"
code "$target_folder"
