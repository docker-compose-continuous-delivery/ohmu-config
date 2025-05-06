#!/usr/bin/env bash

sudo mkdir -p /mnt/appdata/analyst-helper

docker compose up -d --remove-orphans
