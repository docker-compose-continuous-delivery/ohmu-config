# Ensure vaultwarden appdata folder is created
sudo mkdir -p /mnt/appdata/vaultwarden

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"