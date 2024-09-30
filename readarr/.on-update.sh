#!/usr/bin/env bash

sudo mkdir -p /mnt/appdata/readarr
sudo chown -R 1000:1000 /mnt/appdata/readarr

# Ensure the books docker volume exists
sudo mkdir -p /mnt/data/books
sudo chown -R 1000:1000 /mnt/data/books
docker volume create --driver local \
    --opt type=none \
    --opt device=/mnt/data/books \
    --opt o=bind \
    books

docker compose up -d --remove-orphans
