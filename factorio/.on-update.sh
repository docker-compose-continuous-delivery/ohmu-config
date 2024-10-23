#!/usr/bin/env bash

# Make sure the Factorio data directory exists
sudo mkdir -p /opt/factorio

# Restart the container
docker compose up -d --remove-orphans
