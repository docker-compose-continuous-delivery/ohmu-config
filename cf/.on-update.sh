#!/usr/bin/env bash

sudo mkdir -p /mnt/appdata/cf

CHANGED=$(../.scripts/detect-changes.sh Caddyfile)

if [ "$CHANGED" = true ]; then
    echo "One of the monitored files has changed, recreating service"
    docker compose up -d --force-recreate --remove-orphans
else
    echo "No changes detected in monitored files"
    docker compose up -d --remove-orphans
fi
