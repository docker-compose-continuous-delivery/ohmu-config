#!/usr/bin/env bash

# Ensure paperless appdata is created
sudo mkdir -p /mnt/appdata/paperless/app
sudo mkdir -p /mnt/appdata/paperless/media

# Restart all containers
docker compose up -d --remove-orphans
