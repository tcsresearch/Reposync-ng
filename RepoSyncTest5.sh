#!/bin/env bash

# shellcheck disable=SC2034
# shellcheck source=/dev/null

# Configuration #
CONFIG_FILE="$(pwd)/config/RepoSyncTest.conf"
FUNC_FILE="$(pwd)/RepoSyncTest4.bfunc"
EXCLUDES_FILE="$(pwd)/excludes/excludes.list"
COLORS_FILE="$(pwd)/config/Colors2.conf"

IS_ColorsFile_Loaded="0"



function SanityChecker_ColorsFileExists() {
# Ensure the colors file exists
	if [ -f "$COLORS_FILE" ]; then
    	source "$COLORS_FILE"
		Is_ColorsFile_Loaded="1"
	else
    	echo "ERROR: Excludes file $COLORS_FILE not found." >&2
    	return 1
fi
}

function SanityChecker_ExcludesFileExists() {
# Ensure the excludes file exists
	if [ ! -f "$EXCLUDES_FILE" ]; then
    		echo "Error: Excludes file '$EXCLUDES_FILE' not found." >&2
    		exit 1
	fi
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

# LoadColors

SanityChecker_ColorsFileExists
SanityChecker_ExcludesFileExists

# SanityChecker RepoSyncTest.bfunc

DetermineNumOfExcludes
ProcessExcludesFile
CheckRules_Excludes

