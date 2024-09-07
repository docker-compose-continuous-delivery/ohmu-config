# Ensure vaultwarden appdata folder is created
sudo mkdir -p /mnt/appdata/vaultwarden

# Update Secrets
PROJECT_ID="283b6833-0f25-467d-8146-e358254afc01"

# Export secrets and compare directly with the existing .env file
if ! infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod | cmp -s - .env; then
    # If different, update the existing .env file
    infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod > .env
    echo "Configs updated from Infisical"
else
    echo "Configs are identical, no update needed"
fi

# Restart all containers
docker compose up -d --remove-orphans