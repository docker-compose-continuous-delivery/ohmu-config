#!/usr/bin/env bash

# Make sure the "bookstack" appdata folders exists
sudo mkdir -p /mnt/appdata/hedgedoc/app
sudo mkdir -p /mnt/appdata/hedgedoc/db

../.scripts/update_secrets.sh d421a722-30f3-4339-af28-4edc1568eb11 .env

# Restart all containers
docker compose up -d --remove-orphans
