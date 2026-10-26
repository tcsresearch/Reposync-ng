#!/bin/env bash

# shellcheck source=/dev/null

# Define Files / Folders
EXCLUDES_FOLDER="$(pwd)/excludes"
EXCLUDES_FILE="excludes.list"
EXCLUDES_URL="https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list"

# Define Backup File Date Format
$DateFmt="$(date +%Y%m%d)"

#################################################################################
# Define Functions #                                                            #
#################################################################################

function DetermineNumOfExcludes() {
# Read excludes file and determine the number of excluded packages
	# NumOfExcludes=$(grep -cvE '^\s*(#|$)' excludes.list)
   NumOfExcludes=$(grep -cvE '^\s*(#|$)' $EXCLUDES_FOLDER/$EXCLUDES_FILE)
}

function NewLine() {
  echo " "
}

function OriginalFileInfo() {
# Display Original Excludes File Info
  echo "Original Excludes File Info:"
  # echo "Excludes File Last Updated:"
  cat $EXCLUDES_FOLDER/$EXCLUDES_FILE | grep '# Last Updated:'
  DetermineNumOfExcludes
}

function BackupExcludesFile() {
# Backup Original Excludes File
  echo "Backing up existing excludes file..."
  mv -v $EXCLUDES_FOLDER/excludes.list $EXCLUDES_FOLDER/excludes-backup-$DateFmt
}

function FetchLatestExcludesFile() {
# Fetch Latest Excludes File
  echo "Fetching Latest Excludes File..."
  wget -P $EXCLUDES_FOLDER $EXCLUDES_URL
  echo "Retrieved Latest Excludes File Successfully."
}

function NewFileInfo() {
# Display New Excludes File Info
  echo "New Excludes File Info:"
  # echo "Excludes File Last Updated:"
  cat $EXCLUDES_FOLDER/$EXCLUDES_FILE | grep '# Last Updated:'
  DetermineNumOfExcludes
}

#################################################################################
# Main Program #                                                              #
#################################################################################

# DisplayBanner

BackupExcludesFile
FetchLatestExcludesFile

OriginalFileInfo
NewFileInfo


