# If .env is missing, create it
if [ ! -f .env ]; then
    echo "ENCRYPTION_KEY=$(openssl rand -hex 16)" > .env
    echo "AUTH_SECRET=$(openssl rand -base64 32)" >> .env
fi

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"