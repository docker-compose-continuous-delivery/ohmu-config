# Update Secrets
PROJECT_ID="8f952ab8-e2c4-4203-b153-3a723bca4702"
infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod > .env

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"