# Update Secrets
PROJECT_ID="a054ea85-57a7-4c13-b841-1b432915bda4"
infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod > .env

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"