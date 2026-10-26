#!/bin/env bash

# shellcheck source=/dev/null
# shellcheck disable=SC2034

# Define Program Version
Cfg_EUU_Version="26.10.1"

# Define Backup File Date Format
Cfg_DateFmt="$(date +%Y%m%d)"

# Define Files / Folders
Cfg_EXCLUDES_FOLDER="/home/mirrors/___000-dnf5-repos/Fedora/excludes"
Cfg_EXCLUDES_FILE="excludes.list"
Cfg_EXCLUDES_URL="https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list"
Cfg_BACKUP_PROG="BackupExcludes.sh"
Cfg_BACKUP_FILE="excludes-backup-$(Cfg_DateFmt)"

# Define Fetching App / Args
Cfg_FetchApp="wget" # Can be: wget/aria2/curl
Cfg_FetchApp_Wget_Args=" -q --show-progress" 
Cfg_FetchApp_Aria2_Args=" "
Cfg_FetchApp_Curl_Args=" "

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
  ## mv -v "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE" "$Cfg_EXCLUDES_FOLDER"/"$Cfg_BACKUP_FILE"
  ##	mv -v "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE" "$Cfg_EXCLUDES_FOLDER"/excludes-backup_"$DateFmt"
  # sh BackupExcludes.sh
	sh "$Cfg_BACKUP_PROG"
	NewLine
}

function FetchLatestExcludesFile() {
# Fetch Latest Excludes File
  echo "Fetching Latest Excludes File..."
  ## $Cfg_FetchApp "$Cfg_FetchApp_Wget_Args" -P "$Cfg_EXCLUDES_FOLDER" "$Cfg_EXCLUDES_URL"
  wget -q --show-progress -P "$Cfg_EXCLUDES_FOLDER" "$Cfg_EXCLUDES_URL"
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


