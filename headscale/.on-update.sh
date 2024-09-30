#!/usr/bin/env bash

# Make sure the "flomepage" appdata folders exists
sudo mkdir -p /mnt/appdata/headscale

# Update secrets
../.scripts/update_secrets.sh 44b388c3-2ede-4c9e-8d14-06adb9d6a2de .env

# Restart all containers
docker compose up -d --remove-orphans
