# Update Secrets
infisical export --format=dotenv --projectId 09b0a40c-0431-4596-a6cb-47e7c6cb767b --domain https://infisical.ozeliurs.com -e prod > .env

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"