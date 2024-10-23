#!/usr/bin/env bash

set -e

sudo mkdir -p /mnt/appdata/forgejo-runner
sudo touch /mnt/appdata/forgejo-runner/.runner
sudo mkdir -p /mnt/appdata/forgejo-runner/.cache

sudo chown -R 1001:1001 /mnt/appdata/forgejo-runner/.runner
sudo chown -R 1001:1001 /mnt/appdata/forgejo-runner/.cache
sudo chmod 775 /mnt/appdata/forgejo-runner/.runner
sudo chmod 775 /mnt/appdata/forgejo-runner/.cache
sudo chmod g+s /mnt/appdata/forgejo-runner/.runner
sudo chmod g+s /mnt/appdata/forgejo-runner/.cache

docker compose up -d --remove-orphans
