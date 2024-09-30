#!/usr/bin/env bash

# Make sure the required folders exists
sudo mkdir -p /mnt/appdata/viseron
sudo mkdir -p /mnt/data/viseron

# Update secrets
../.scripts/update_secrets.sh 954bd56a-581e-42c9-a383-bdc9fc9bb262 .env

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
