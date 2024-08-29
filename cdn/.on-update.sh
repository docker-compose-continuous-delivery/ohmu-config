# Make sure the "bookstack" appdata folders exists
sudo mkdir -p /mnt/data

# List of files to monitor for changes
FILES_TO_MONITOR=("Caddyfile")

# Check if any of the specified files have changed
CHANGED=false
for FILE in "${FILES_TO_MONITOR[@]}"; do
    if git diff --name-only HEAD@{1} HEAD | grep -q "$FILE"; then
        CHANGED=true
        break
    fi
done

if [ "$CHANGED" = true ]; then
    echo "One of the monitored files has changed, recreating service"
    docker compose up -d --force-recreate --remove-orphans
else
    echo "No changes detected in monitored files"
    docker compose up -d --remove-orphans
fi