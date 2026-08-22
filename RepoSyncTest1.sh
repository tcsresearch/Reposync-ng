#!/bin/env bash

# Configuration
EXCLUDE_FILE="excludes.list"
REPO_ID="fedora" # Change to your target repository ID
DEST_DIR="/var/www/html/repos"

# Ensure the exclude file exists
if [ ! -f "$EXCLUDE_FILE" ]; then
    echo "Error: Exclude file '$EXCLUDE_FILE' not found." >&2
    exit 1
fi

# Read the file, ignore blank lines/comments, and join with commas
mapfile -t exclude_array < <(grep -v -E '^\s*(#|$)' "$EXCLUDE_FILE" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# Check if there are any rules to process
if [ ${#exclude_array[@]} -eq 0 ]; then
    echo "Warning: No exclusions found in $EXCLUDE_FILE. Syncing entire repository..."
    dnf5 reposync --repo="$REPO_ID" --destdir="$DEST_DIR" --download-metadata --delete
else
    # Combine array elements into a single comma-separated string
    exclude_string=$(IFS=,; echo "${exclude_array[*]}")

    echo "Syncing repository: $REPO_ID"
    echo "Excluding packages: $exclude_string"

    # Execute DNF5 reposync
    dnf5 reposync \
        --repo="$REPO_ID" \
        --destdir="$DEST_DIR" \
        --exclude="$exclude_string" \
        --download-metadata \
        --delete
fi
