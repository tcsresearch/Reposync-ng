#!/bin/env bash

# shellcheck source=/dev/null
# shellcheck disable=SC2034

# Define Program Version
Cfg_EUU_Version="26.10.2"

# Define Backup File Date Format
Cfg_DateFmt="$(date +%Y%m%d)"

# Define Files / Folders
Cfg_EXCLUDES_FOLDER="./excludes"
Cfg_EXCLUDES_FILE="excludes.list"
Cfg_EXCLUDES_URL="https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list"
Cfg_BACKUP_PROG="BackupExcludes.sh"
Cfg_BACKUP_FILE="excludes-backup-$Cfg_DateFmt"

# Define Fetching App / Args
Cfg_FetchApp="wget" # Can be: wget/aria2/curl
Cfg_FetchApp_Wget_Args=" -q --show-progress" 
Cfg_FetchApp_Aria2_Args=" "
Cfg_FetchApp_Curl_Args=" "

#################################################################################
# Define Display Functions #                                                    #
#################################################################################

function DisplayBanner() {
	echo "Excludes Update Utility - Version $Cfg_EUU_Version."
	NewLine
}

function NewLine() {
  echo " "
}

function DisplayLine() {
	echo "---------------------------------------------"
}

function NewLineCinema() {
	NewLine
	DisplayLine
	NewLine
}

function ShowVars() {
	echo "$0 - Configuration Values:"
	DisplayLine
	for var in ${!Cfg_*}; do
    	echo "$var = ${!var}"
	done
}

#################################################################################
# Define Excludes Counting Functions #                                          #
#################################################################################

function DetermineNumOfExcludes() {
# Read excludes file and determine the number of excluded packages
	# NumOfExcludes=$(grep -cvE '^\s*(#|$)' excludes.list)
   NumOfExcludes=$(grep -cvE '^\s*(#|$)' "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE")
}

function CountExcludes(){
	DetermineNumOfExcludes
}

function ShowNumOfExcludes() {
	echo "Number Of Excludes: $NumOfExcludes"
	NewLine
}

#################################################################################
# Define File Info Functions #                                                  #
#################################################################################

function OriginalFileInfo() {
# Display Original Excludes File Info
  echo "Original Excludes File Info:"
  # echo "Excludes File Last Updated:"
  cat "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE" | grep '# Last Updated:'
  DetermineNumOfExcludes
}

function NewFileInfo() {
# Display New Excludes File Info
  echo "New Excludes File Info:"
  # echo "Excludes File Last Updated:"
  cat "$Cfg_EXCLUDES_FOLDER"/"$Cfg_EXCLUDES_FILE" | grep '# Last Updated:'
  DetermineNumOfExcludes
}

#################################################################################
# Define Excludes Backup / Fetching Functions #                                 #
#################################################################################

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
  ## wget -q --show-progress -P "$Cfg_EXCLUDES_FOLDER" "$Cfg_EXCLUDES_URL" # FIXME: Download doesn't save in correct place; falling back to manual (no vars!)
  wget -q --show-progress -P excludes https://github.com/tcsresearch/Reposync-ng/raw/refs/heads/main/excludes/excludes.list -O excludes.list
  wget -q --show-progress -P excludes "$Cfg_EXCLUDES_URL" -O "$Cfg_EXCLUDES_FILE"
  echo "Retrieved Latest Excludes File Successfully."
  NewLine
}


#################################################################################
# Main Program #                                                                #
#################################################################################

DisplayBanner

BackupExcludesFile
FetchLatestExcludesFile

OriginalFileInfo
NewFileInfo


