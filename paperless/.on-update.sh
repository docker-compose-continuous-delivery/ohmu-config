# Ensure paperless appdata is created
mkdir -p /mnt/appdata/paperless/app
mkdir -p /mnt/appdata/paperless/media

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"