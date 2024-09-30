#!/usr/bin/env bash

mkdir -p /mnt/appdata/wakapi

# Restart all containers
docker compose up -d --remove-orphans
