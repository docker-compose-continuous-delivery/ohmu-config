# Update Secrets
PROJECT_ID="bdac0f34-6a92-4023-84d6-7f89a81171c5"
infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod > .env

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"