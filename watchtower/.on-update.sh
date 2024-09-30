#!/usr/bin/env bash

# Update secrets
../.scripts/update_secrets.sh a054ea85-57a7-4c13-b841-1b432915bda4 .env

# Restart all containers
docker compose up -d --remove-orphans
