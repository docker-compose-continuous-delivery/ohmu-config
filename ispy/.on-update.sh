sudo mkdir -p /mnt/data/ispy
sudo mkdir -p /mnt/appdata/ispy

# Restart all containers
docker compose up -d --remove-orphans