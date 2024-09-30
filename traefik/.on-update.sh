#!/usr/bin/env bash

# Make sure the "traefik" network exists
docker network create traefik 2> /dev/null

CHANGED=$(../.scripts/detect-changes.sh traefik.yml)

if [ "$CHANGED" = true ]; then
    echo "One of the monitored files has changed, recreating service"
    docker compose up -d --force-recreate --remove-orphans
else
    echo "No changes detected in monitored files"
    docker compose up -d --remove-orphans
fi
