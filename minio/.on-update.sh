# Update Secrets
PROJECT_ID="09b0a40c-0431-4596-a6cb-47e7c6cb767b"
infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod > .env

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"