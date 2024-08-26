# Make sure the "traefik" network exists
docker network create traefik 2> /dev/null

# Restart all containers
docker compose up -d --force-recreate --remove-orphans

echo "Successfully updated!"