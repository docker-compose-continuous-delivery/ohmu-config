# Ensure appdata dirs are created
sudo mkdir -p /mnt/appdata/fusion

# Update Secrets
PROJECT_ID="d30cfe39-d335-4123-b88d-1f15ef80935e"

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