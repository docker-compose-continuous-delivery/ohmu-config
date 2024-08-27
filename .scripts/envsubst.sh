#!/bin/bash

# Initialize verbosity flag to false
VERBOSE=false

# Parse command-line options
while getopts ":v" opt; do
  case $opt in
    v)
      VERBOSE=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "Usage: $0 [-v] path/to/.env path/to/input.yml path/to/output.yml"
      exit 1
      ;;
  esac
done

# Shift the positional arguments to skip the processed options
shift $((OPTIND - 1))

# Check if the correct number of positional arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [-v] path/to/.env path/to/input.yml path/to/output.yml"
    exit 1
fi

# Assign positional arguments to variables
ENV_FILE="$1"
INPUT_FILE="$2"
OUTPUT_FILE="$3"

# Ensure .env file exists
if [[ ! -f "$ENV_FILE" ]]; then
    echo ".env file not found at $ENV_FILE!"
    exit 1
fi

# Ensure input YAML file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Input YAML file not found at $INPUT_FILE!"
    exit 1
fi

# Load .env variables
export $(grep -v '^#' "$ENV_FILE" | xargs)

# Copy input YAML file to output YAML file
cp "$INPUT_FILE" "$OUTPUT_FILE"

# Print verbose message if enabled
if $VERBOSE; then
  echo "Copying $INPUT_FILE to $OUTPUT_FILE..."
fi

# Iterate over each line in .env file to replace placeholders in output YAML file
while IFS= read -r line; do
  # Skip empty lines and comments
  if [[ -z "$line" || "$line" == \#* ]]; then
    continue
  fi

  # Extract key and value
  key=$(echo "$line" | cut -d '=' -f 1)
  value=$(echo "$line" | cut -d '=' -f 2-)

  # Remove both single and double quotes from the value if they exist
  value=$(echo "$value" | sed "s/^'//; s/'\$//; s/^\"//; s/\"$//")

  # Print verbose message if enabled
  if $VERBOSE; then
    echo "Replacing {{ $key }} with \"$value\" in $OUTPUT_FILE..."
  fi

  # Replace the placeholder with the value in the output YAML file
  sed -i '' -e "s|{{ $key }}|$value|g" "$OUTPUT_FILE"
done < "$ENV_FILE"

echo "Replacement done! Check $OUTPUT_FILE for results."