# Make sure the appdata folders exists
sudo mkdir -p /mnt/appdata/gatus

# Update Secrets
PROJECT_ID="13bd2f48-dcac-4f12-82c5-0857af82cfa1"

# Export secrets and compare directly with the existing .env file
if ! infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod | cmp -s - .env; then
    # If different, update the existing .env file
    infisical export --format=dotenv --projectId $PROJECT_ID --domain https://infisical.ozeliurs.com -e prod > .env
    echo "Configs updated from Infisical"
else
    echo "Configs are identical, no update needed"
fi

../.scripts/envsubst.sh .env config.tpl.yaml config.yaml

# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"