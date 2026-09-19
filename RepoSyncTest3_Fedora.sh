#!/bin/env bash

# Configuration
EXCLUDES_FILE="excludes.list"
REPO_ID="fedora" # Change to your target repository ID
DEST_DIR="/home/mirrors/dnf5-repos/Fedora"

function SanityChecker_ExcludesFileExists() {
# Ensure the excludes file exists
	if [ ! -f "$EXCLUDES_FILE" ]; then
    		echo "Error: Excludes file '$EXCLUDES_FILE' not found." >&2
    		exit 1
	fi
}

function DetermineNumOfExcludes() {
# Read excludes file and determine the number of excluded packages
	NumOfExcludes=$(grep -cvE '^\s*(#|$)' excludes.list)
}

function ProcessExcludesFile () {
# Read the file, ignore blank lines/comments, and join with commas
	mapfile -t exclude_array < <(grep -v -E '^\s*(#|$)' "$EXCLUDES_FILE" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
}


function DisplayBanner() {
    echo "-----------------------------------------------------"
    echo "Syncing Repository: $REPO_ID"
    echo "-----------------------------------------------------"
    echo "Excludes File: $EXCLUDES_FILE"
    echo "-----------------------------------------------------"
    echo "Number Of Excludes: $NumOfExcludes"
    echo "-----------------------------------------------------"
    echo "Excluding Packages: $exclude_string"
    echo "-----------------------------------------------------"
}


function Do_RepoSync() {
    # Execute DNF5 reposync
    dnf5 reposync \
        --repo="$REPO_ID" \
        --destdir="$DEST_DIR" \
        --exclude="$exclude_string" \
        --download-metadata \
        --delete
}

function CheckRules_Excludes() {
# Check if there are any rules to process
	if [ ${#exclude_array[@]} -eq 0 ]; then
    	   echo "Warning: No exclusions found in $EXCLUDES_FILE. Syncing entire repository..."
    	   dnf5 reposync --repo="$REPO_ID" --destdir="$DEST_DIR" --download-metadata --delete
	else
    	# Combine array elements into a single comma-separated string
    	  exclude_string=$(IFS=,; echo "${exclude_array[*]}")

          DisplayBanner
	  Do_RepoSync
fi
}

##################################################################################
# Main Program #								 #
##################################################################################

SanityChecker_ExcludesFileExists
DetermineNumOfExcludes
ProcessExcludesFile
CheckRules_Excludes

