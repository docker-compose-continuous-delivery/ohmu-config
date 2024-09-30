#!/usr/bin/env bash

# Make sure the "bookstack" appdata folders exists
sudo mkdir -p /mnt/appdata/bookstack/app
sudo mkdir -p /mnt/appdata/bookstack/db

# Update secrets
../.scripts/update_secrets.sh 885556d1-dfc6-40ef-867f-7bcb446455fd .env

# Restart all containers
docker compose up -d --remove-orphans
