#!/usr/bin/env bash

# Make sure the appdata folders exists
sudo mkdir -p /mnt/appdata/gatus

# Update secrets
../.scripts/update_secrets.sh 13bd2f48-dcac-4f12-82c5-0857af82cfa1 .env

export "$(grep -v '^#' .env | xargs)"
envsubst < config.tpl.yaml > config.yaml

CHANGED=$(../.scripts/detect-changes.sh config.tpl.yaml)

if [ "$CHANGED" = true ]; then
    echo "One of the monitored files has changed, recreating service"
    docker compose up -d --force-recreate --remove-orphans
else
    echo "No changes detected in monitored files"
    docker compose up -d --remove-orphans
fi
