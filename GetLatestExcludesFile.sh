#!/bin/env bash


EXCLUDES_FILE="https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list"

echo "Fetching Latest Excludes File..."
wget -c $EXCLUDES_FILE
