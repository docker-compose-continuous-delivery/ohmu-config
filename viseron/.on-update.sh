#!/usr/bin/env bash

# Make sure the required folders exists
sudo mkdir -p /mnt/appdata/viseron
sudo mkdir -p /mnt/data/viseron

# Update secrets
../.scripts/update_secrets.sh 954bd56a-581e-42c9-a383-bdc9fc9bb262 .env

export $(grep -v '^#' .env | xargs)
envsubst < config.tpl.yaml > config.yaml

# List of files to monitor for changes
FILES_TO_MONITOR=("config.tpl.yaml")

# Check if any of the specified files have changed
CHANGED=false
for FILE in "${FILES_TO_MONITOR[@]}"; do
    if git diff --name-only HEAD@{1} HEAD | grep -q "$FILE"; then
        CHANGED=true
        break
    fi
done

if [ "$CHANGED" = true ]; then
    echo "One of the monitored files has changed, recreating service"
    docker compose up -d --force-recreate --remove-orphans
else
    echo "No changes detected in monitored files"
    docker compose up -d --remove-orphans
fi
