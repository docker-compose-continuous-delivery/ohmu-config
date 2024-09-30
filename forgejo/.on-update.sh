#!/usr/bin/env bash

# Ensure appdata dirs are created
sudo mkdir -p /mnt/appdata/forgejo

# Restart all containers
docker compose up -d --remove-orphans
