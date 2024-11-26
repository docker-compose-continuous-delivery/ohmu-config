#!/usr/bin/env bash

sudo mkdir -p /mnt/appdata/snipeit/app /mnt/appdata/snipeit/db
sudo chown -R 1000:1000 /mnt/appdata/snipeit

docker compose up -d --remove-orphans
