## Installation

Add the cronjob to your crontab file:

```cronexp
* * * * * /path_to_this_repo/.update.sh > /path_to_this_repo/.update.log
```

## Usage

### `.on-update` template

Basic template for docker compose services:

```bash
# Restart all containers
docker compose up -d --remove-orphans

echo "Successfully updated!"
```

More complex example with infisical:

⚠️ __Make sure to have a .env ar the root containing `INFISICAL_TOKEN=<TOKEN>`__ ⚠️

```bash
# Update Secrets
PROJECT_ID="<PROJECT_ID>"

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
```