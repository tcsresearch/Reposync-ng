#!/bin/env bash

# shellcheck source=/dev/null

# Define Program Version
Cfg_EUU_Version="26.10"

# Define Backup File Date Format
Cfg_DateFmt="$(date +%Y%m%d)"

# Define Files / Folders
Cfg_EXCLUDES_FOLDER="$(pwd)/excludes"
Cfg_EXCLUDES_FILE="excludes.list"
Cfg_EXCLUDES_URL="https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list"
Cfg_BACKUP_FILE="excludes-backup-$(Cfg_DateFmt)"

#################################################################################
# Define Functions #                                                            #
#################################################################################

function DisplayBanner() {
	echo "Excludes Update Utility - Version $Cfg_EUU_Version."
	NewLine
}

function ShowVars() {
	# Define Program Version
for var in ${!Cfg_*}; do
    echo "$var = ${!var}"
done
}


function DetermineNumOfExcludes() {
# Read excludes file and determine the number of excluded packages
	# NumOfExcludes=$(grep -cvE '^\s*(#|$)' excludes.list)
   NumOfExcludes=$(grep -cvE '^\s*(#|$)' "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE")
}

function NewLine() {
  echo " "
}

function OriginalFileInfo() {
# Display Original Excludes File Info
  echo "Original Excludes File Info:"
  # echo "Excludes File Last Updated:"
  cat "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE" | grep '# Last Updated:'
  DetermineNumOfExcludes
}

function BackupExcludesFile() {
# Backup Original Excludes File
  echo "Backing up existing excludes file..."
  mv -v "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE" "$Cfg_EXCLUDES_FOLDER"/"$Cfg_BACKUP_FILE"
}

function FetchLatestExcludesFile() {
# Fetch Latest Excludes File
  echo "Fetching Latest Excludes File..."
  wget -P "$Cfg_EXCLUDES_FOLDER" "$Cfg_EXCLUDES_URL"
  echo "Retrieved Latest Excludes File Successfully."
}

function NewFileInfo() {
# Display New Excludes File Info
  echo "New Excludes File Info:"
  # echo "Excludes File Last Updated:"
  cat "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE" | grep '# Last Updated:'
  DetermineNumOfExcludes
}

#################################################################################
# Main Program #                                                              #
#################################################################################

DisplayBanner

BackupExcludesFile
FetchLatestExcludesFile

OriginalFileInfo
NewFileInfo


