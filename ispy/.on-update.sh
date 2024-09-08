mkdir -p /mnt/data/ispy
mkdir -p /mnt/appdata/ispy

# Restart all containers
docker compose up -d --remove-orphans