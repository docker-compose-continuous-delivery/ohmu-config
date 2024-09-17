sudo mkdir -p /mnt/appdata/docmost/app /mnt/appdata/docmost/db /mnt/appdata/docmost/redis

../.scripts/update_secrets.sh 952cfeda-ff14-4a8f-8d89-b141c44d2fc3 .env

docker compose up -d --remove-orphans