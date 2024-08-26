# Make sure the "flomepage" appdata folders exists
sudo mkdir -p /mnt/appdata/headscale

# Update Secrets
PROJECT_ID="44b388c3-2ede-4c9e-8d14-06adb9d6a2de"

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

echo "Successfully updated!"