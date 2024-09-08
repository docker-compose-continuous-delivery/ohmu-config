# Make sure the required folders exists
sudo mkdir -p /mnt/appdata/viseron
sudo mkdir -p /mnt/data/viseron

# Update secrets
../.scripts/update_secrets.sh 954bd56a-581e-42c9-a383-bdc9fc9bb262 .env

../.scripts/envsubst.sh .env config.tpl.yaml config.yaml

# Run docker compose up
docker compose up -d --remove-orphans