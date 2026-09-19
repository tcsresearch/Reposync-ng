#!/bin/env bash

# Configuration #
CONFIG_FILE="RepoSyncTest.conf"
FUNC_FILE="/RepoSyncTest.bfunc"

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



# Sanity Checker #
SanityChecker() {
    local dir="$1"
    local pattern="$2"
    if [[ -d "$dir" ]]; then
        echo "${brightwhite} Sourcing files from: ${brightyellow} $dir ${reset}"
	echo "-------------------------------------------------------------------------------------------"
	# Use a glob to find matching files and loop through them
        for file in "$dir"/$pattern; do
            # Check if the glob found actual files (and not just the literal pattern if no files match)
            if [[ -f "$file" ]]; then
                echo "  ${brightyellow} Sourcing: ${brightblue} $file"
                source "$file"
            fi
        done
    else
        echo "Directory not found: $dir"
    fi
}

##################################################################################
# Main Program #                                                                 #
##################################################################################

LoadColors
SanityChecker RepoSyncTest.bfunc

SanityChecker_ExcludesFileExists
DetermineNumOfExcludes
ProcessExcludesFile
CheckRules_Excludes

