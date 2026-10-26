#!/bin/env bash

EXCLUDES_FILE="https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list"
EXCLUDES_FOLDER="$(pwd)/excludes"

echo "Fetching Latest Excludes File..."
wget -P $EXCLUDES_FOLDER $EXCLUDES_FILE

echo "Retrieved Latest Excludes File Successfully."
# echo "Excludes File Last Updated:"
cat $EXCLUDES_FOLDER/$EXCLUDES_FILE | grep '# Last Updated:'
