#!/bin/bash

EXCLUDE_FILE="excludes-filtered.list"
REPO_ID="fedora"
DOWNLOAD_DIR="<download_path>"

# Read the file and format it into a space-separated list of --exclude flags
EXCLUDE_ARGS=$(awk '{for(i=1;i<=NF;i++) printf "--exclude=%s ", $i}' FS=',' $EXCLUDE_FILE)

# Execute the reposync command with the generated excludes
# dnf reposync --repoid=$REPO_ID -p $DOWNLOAD_DIR $EXCLUDE_ARGS
dnf reposync --repoid=$REPO_ID $EXCLUDE_ARGS
