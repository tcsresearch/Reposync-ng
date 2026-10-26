#!/bin/env bash

# Define Files / Folders
EXCLUDES_FOLDER="$(pwd)/excludes"
EXCLUDES_FILE="excludes.list"
EXCLUDES_URL="https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list"

# Define Backup File Date Format
$DateFmt="$(date +%Y%m%d)"

# Backup Original Excludes File
echo "Backing up existing excludes file..."
mv -v $EXCLUDES_FOLDER/excludes.list $EXCLUDES_FOLDER/excludes-backup-$DateFmt


# Fetch Latest Excludes File
echo "Fetching Latest Excludes File..."
wget -P $EXCLUDES_FOLDER $EXCLUDES_URL

echo "Retrieved Latest Excludes File Successfully."

# Display New Excludes File Info
# echo "Excludes File Last Updated:"
cat $EXCLUDES_FOLDER/$EXCLUDES_FILE | grep '# Last Updated:'
