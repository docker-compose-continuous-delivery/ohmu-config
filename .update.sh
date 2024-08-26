#!/bin/bash

# Save the parent directory of this script to a variable
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Change to the parent of the parent directory of this script
cd $SCRIPT_DIR

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
  echo "Fetching latest changes"
  git fetch

  # Check if there are any changes
  if [[ $(git rev-parse HEAD) == $(git rev-parse @{u}) ]]; then
      echo "No changes to pull"
      exit 0
  fi

  # Pull the latest changes, overwriting any local changes
  echo "Pulling latest changes"
  git pull -X theirs
fi

set -a # automatically export all variables
source .env
set +a

# Run the on-update.sh script
echo "Running on-update.sh for each folder ..."
for f in */; do
    if [ -f "$f.on-update.sh" ]; then
        echo "Running on-update.sh in $f"
        cd $f
        chmod +x .on-update.sh
        ./.on-update.sh
        git restore .on-update.sh
        cd ..
    fi
done