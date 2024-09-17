# Make sure the "flomepage" appdata folders exists
sudo mkdir -p /mnt/appdata/flame

# Update secrets
../.scripts/update_secrets.sh 60e350e8-e249-4794-b034-100acdda7452 .env

# Restart all containers
docker compose up -d --remove-orphans