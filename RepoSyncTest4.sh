#!/bin/env bash
# RepoSyncTest4.sh - This script supercedes RepoSyncTest4_Fedora.sh and RepoSyncTest4_Updates.sh into a single codebase.

# shellcheck disable=SC2034

# Version
RepoSync_Version="26.10"

# Configuration
EXCLUDES_FILE="$(pwd)/excludes/excludes.list"
REPO_ID="$1" # Change to your target repository ID
DEST_DIR="/home/mirrors/dnf5-repos/Fedora"

COLORS_FILE="$(pwd)/config/Colors2.conf"
IS_ColorsFile_Loaded="0"

######################################################################################################################
# COLORS #																											 #
######################################################################################################################
function LoadColors() {
# Define Our Colors
# NEW Sep 14, 2026: Add orange color.
	  black=$(tput setaf 0)
	  red=$(tput setaf 1)
	  green=$(tput setaf 2)
      orange=$(tput setaf 166)
	  yellowbrown=$(tput setaf 3)
	  blue=$(tput setaf 4)
	  magenta=$(tput setaf 5)
	  cyan=$(tput setaf 6)
	  whitelightgray=$(tput setaf 7)
	  whitelightgrey=$(tput setaf 7)
	  brightblack_darkgray=$(tput setaf 8)
	  brightblack_darkgrey=$(tput setaf 8)
	  brightred=$(tput setaf 9)
	  brightgreen=$(tput setaf 10)
	  brightyellow=$(tput setaf 11)
	  brightblue=$(tput setaf 12)
	  brightmagenta=$(tput setaf 13)
	  brightcyan=$(tput setaf 14)
	  brightwhite=$(tput setaf 15)
 	  reset=$(tput sgr0) # Reset to default 
}

######################################################################################################################
# SANITYCHECKER FUNCTIONS #																							 #
######################################################################################################################

function SanityChecker_ColorsFileExists() {
# Ensure the colors file exists
	if [ -f "$COLORS_FILE" ]; then
    source "$COLORS_FILE"
	IS_ColorsFile_Loaded="1"
else
    echo "Error: Excludes file $COLORS_FILE not found." >&2
    return 1
fi
}

function SanityChecker_ExcludesFileExists() {
# Ensure the excludes file exists
	if [ ! -f "$EXCLUDES_FILE" ]; then
    		echo "Error: Excludes file '$EXCLUDES_FILE' not found." >&2
    		return 1
	fi
}

######################################################################################################################
# DEFINE DISPLAY FUNCTIONS #																						 #
######################################################################################################################

function DisplayBanner() {
	echo "$0 - Version $RepoSync_Version
}

function NewLine() {
	echo " "
}

function DisplayLine() {
	echo "-------------------------------------"
}

function NewLineCinema(){
	NewLine
	DisplayLine
	NewLine
}

######################################################################################################################
# EXCLUDES FUNCTIONS #																								 #
######################################################################################################################

function DetermineNumOfExcludes() {
# Read excludes file and determine the number of excluded packages
	NumOfExcludes=$(grep -cvE '^\s*(#|$)' excludes.list)
}

function ProcessExcludesFile () {
# Read the file, ignore blank lines/comments, and join with commas
	mapfile -t exclude_array < <(grep -v -E '^\s*(#|$)' "$EXCLUDES_FILE" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
}



######################################################################################################################
# DEFINE REPOSYNCYBANNER FUNCTIONS #																				 #
######################################################################################################################

RepoSyncBanner() {
    if [ "$Is_ColorsFile_Loaded" = "1" ]; then
        DisplayBanner_WithColor
    else
        DisplayBanner_NoColor
    fi
}


function RepoSyncBanner_NoColor() {
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

function RepoSyncBanner_WithColor() {
    echo "${green}-----------------------------------------------------${reset}"
    echo "Syncing Repository: $REPO_ID"
    echo "${green}-----------------------------------------------------${reset}"
    echo "Excludes File: $EXCLUDES_FILE"
    echo "${green}-----------------------------------------------------${reset}"
    echo "Number Of Excludes: $NumOfExcludes"
    echo "${green}-----------------------------------------------------${reset}"
    echo "Excluding Packages: $exclude_string"
    echo "${green}-----------------------------------------------------${reset}"
}

######################################################################################################################
# REPO SELECTION FUNCTIONS #																						 #
######################################################################################################################

function ReadRepoInputVal(){
  # Example input variable (replace with your variable or argument)
  INPUT_VAL="$1"

  case "$INPUT_VAL" in
      fedora|Fedora)
          REPO_ID="fedora"
          ;;
      updates|Updates)
          REPO_ID="updates"
          ;;
      *)
          REPO_ID="unknown"
          ;;
  esac

  echo "REPO_ID is set to: $REPO_ID"
}


function RepoSelect() {
	# 1. Check if an argument was provided
		if [ -z "$1" ]; then
    		echo "Error: Missing argument. Please specify 'fedora' or 'updates'." >&2
    		echo "Usage: $0 [fedora|updates]" >&2
    		return 1
		fi

	# 2. Assign the argument to REPO_ID
		REPO_ID="$1"

	# 3. Validate the input using a case statement
		case "$REPO_ID" in
    		"fedora"|"updates")
        		echo "Success: REPO_ID set to '$REPO_ID'"
        		# Your main script logic goes here
				RunMain
        	;;
    		*)
        	echo "Error: Invalid argument '$REPO_ID'." >&2
        	echo "Allowed options are 'fedora' or 'updates'." >&2
        	return 1
        	;;
		esac
}


######################################################################################################################
# DEFINE REPOSYNC/EXCLUDES FUNCTIONS #																				 #
######################################################################################################################

function Do_RepoSync_NoExcludes() {
    # Execute DNF5 reposync
    dnf5 reposync \
        --repo="$REPO_ID" \
        --destdir="$DEST_DIR" \
        --download-metadata \
        --delete
}

function Do_RepoSync_WithExcludes() {
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
    	   echo "[ WARNING ]: No exclusions found in $EXCLUDES_FILE. Syncing entire repository..."
    	   # dnf5 reposync --repo="$REPO_ID" --destdir="$DEST_DIR" --download-metadata --delete
		  Do_RepoSync_NoExcludes
	else
    	# Combine array elements into a single comma-separated string
    	  exclude_string=$(IFS=,; echo "${exclude_array[*]}")

          RepoSyncBanner
	  	  Do_RepoSync_WithExcludes
	fi
}

function RunMain() {
	DetermineNumOfExcludes
	ProcessExcludesFile
	CheckRules_Excludes
}

##################################################################################
# Main Program #																 #
##################################################################################

LoadColors
DisplayBanner

# SanityChecker_ColorsFileExists
SanityChecker_ExcludesFileExists

RepoSelect
# ReadRepoInputVal
# SanityChecker_CheckRepoInputVal

# Superceded by RunMain()
# DetermineNumOfExcludes
# ProcessExcludesFile
# CheckRules_Excludes

# Called by RepoSelect
# RunMain
