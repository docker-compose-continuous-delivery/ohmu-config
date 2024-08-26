# Make sure the "bookstack" appdata folders exists
sudo mkdir -p /mnt/appdata/hedgedoc/app
sudo mkdir -p /mnt/appdata/hedgedoc/db

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"