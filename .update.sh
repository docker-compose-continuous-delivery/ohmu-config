#!/usr/bin/env bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Save the parent directory of this script to a variable
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Change to the parent of the parent directory of this script
cd "$SCRIPT_DIR/.." || exit

# Define lock file
LOCK_FILE="/tmp/update_script.lock"

# Check if the script is already running
if [ -f "$LOCK_FILE" ]; then
    echo "${RED}[!] The script is already running${NC}"
    exit 1
fi

# Create lock file
touch "$LOCK_FILE"

# Trap to remove lock file on exit
trap 'rm -f "$LOCK_FILE"; exit $?' INT TERM EXIT

# Parse command-line arguments
FORCE_UPDATE=false
while getopts "f" opt; do
  case ${opt} in
    f )
      FORCE_UPDATE=true
      ;;
    \? )
      echo "Usage: cmd [-f]"
      exit 1
      ;;
  esac
done

# Fetch the latest changes from the remote if not forcing update
if [ "$FORCE_UPDATE" = false ]; then
  echo "${YELLOW}[+] Fetching latest changes${NC}"
  git fetch

  # Check if there are any changes
  if [[ $(git rev-parse HEAD) == $(git rev-parse '@{u}') ]]; then
      echo "${YELLOW}[+] No changes to pull${NC}"
      exit 0
  fi

  # Pull the latest changes, overwriting any local changes
  echo "${YELLOW}[+] Pulling latest changes${NC}"
  git pull -X theirs
fi

set -a # automatically export all variables

# shellcheck disable=SC1091
source .env

set +a

# Run the on-update.sh script
echo "${YELLOW}[+] Running on-update.sh for each folder ...${NC}"
for f in */; do
    if [ -f "$f.on-update.sh" ]; then
    echo "${YELLOW}[+] Running on-update.sh in $f${NC}"
    (
        cd "$f" || exit
        chmod +x .on-update.sh
        if ./.on-update.sh; then
            echo -e "${GREEN}[+] Update successful in $f${NC}"
        else
            echo -e "${RED}[+] Update failed in $f${NC}"
        fi
        git restore .on-update.sh
    )
    fi
done
