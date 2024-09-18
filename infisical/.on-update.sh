# If .env is missing, create it
if [ ! -f .env ]; then
    echo "ENCRYPTION_KEY=$(openssl rand -hex 16)" > .env
    echo "AUTH_SECRET=$(openssl rand -base64 32)" >> .env
    echo "POSTGRES_PASSWORD=$(openssl rand -base64 32)" >> .env
fi

echo "Infisical does not update automatically, please check for updates manually"