#!/bin/bash

# Check if at least one file argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file1> [file2] [file3] ..."
    exit 1
fi

# Initialize CHANGED variable
CHANGED=false

# Loop through all provided file arguments
for FILE in "$@"; do
    if git diff --name-only HEAD@{1} HEAD | grep -q "$FILE"; then
        CHANGED=true
        break
    fi
done

# Output the result in a way that can be captured by the calling script
echo "$CHANGED"
