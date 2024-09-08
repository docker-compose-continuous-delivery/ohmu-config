sudo mkdir -p /mnt/data/ispy
sudo mkdir -p /mnt/appdata/ispy

sudo chown 1000 -R /mnt/data/ispy
sudo chown 1000 -R /mnt/appdata/ispy

# Restart all containers
docker compose up -d --remove-orphans