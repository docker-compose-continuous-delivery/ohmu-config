#!/bin/bash

# Function to print error messages in red
print_error() {
    echo -e "\e[31mError: $1\e[0m"
}

# Check if the required parameters are provided
if [ $# -ne 2 ]; then
    print_error "Usage: $0 <project_id> <path_to_env_file>"
    exit 1
fi

# Assign parameters to variables
PROJECT_ID=$1
ENV_FILE=$2

# Check if 'infisical' is installed
if ! command -v infisical &> /dev/null; then
    print_error "'infisical' command not found. Please install Infisical."
    exit 1
fi

# Export secrets and check for errors
if ! infisical export --format=dotenv --projectId "$PROJECT_ID" --domain https://infisical.ozeliurs.com -e prod &> /dev/null; then
    print_error "'infisical' command failed. Please check your configuration."
    exit 1
fi

# Compare the exported secrets with the existing .env file
if ! infisical export --format=dotenv --projectId "$PROJECT_ID" --domain https://infisical.ozeliurs.com -e prod | cmp -s - "$ENV_FILE"; then
    # If different, update the existing .env file
    infisical export --format=dotenv --projectId "$PROJECT_ID" --domain https://infisical.ozeliurs.com -e prod > "$ENV_FILE"
    echo "Configs updated from Infisical"
else
    echo "Configs are identical, no update needed"
fi