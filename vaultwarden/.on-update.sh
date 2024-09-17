# Ensure vaultwarden appdata folder is created
sudo mkdir -p /mnt/appdata/vaultwarden

# Update secrets
../.scripts/update_secrets.sh 283b6833-0f25-467d-8146-e358254afc01 .env

# Restart all containers
docker compose up -d --remove-orphans