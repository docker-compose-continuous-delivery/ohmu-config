#!/usr/bin/env bash

# Make sure the "bitmagnet" appdata folders exists
sudo mkdir -p /mnt/appdata/bitmagnet/postgres

# Update secrets
../.scripts/update_secrets.sh <unique-uuid> .env

# Restart all containers
docker compose up -d --remove-orphans
