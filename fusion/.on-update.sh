# Ensure appdata dirs are created
sudo mkdir -p /mnt/appdata/fusion

# Update secrets
../.scripts/update_secrets.sh d30cfe39-d335-4123-b88d-1f15ef80935e .env

# Restart all containers
docker compose up -d --remove-orphans