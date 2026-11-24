#!/bin/env bash

# Define Excludes File
Excludes_Folder="excludes"
Excludes_File="excludes.list"

echo "Excludes File: $Excludes_Folder/$Excludes_File"
echo " "

# TODO: Sanity Checker for excludes file.
function SanityChecker() {
	if [[ -f "$Excludes_Folder/$Excludes_File" ]]; then
    		CountLines
	else
    		echo "ERROR: Excludes File not found." >&2
    	return 1
	fi
}


# Count Lines
function CountLines() {
	echo "Number Of Excludes: "
	# grep -vE '^\s*(#|$)' excludes.list | wc -l
	 grep -vE '^\s*(#|$)' "$Excludes_Folder/$Excludes_File" | wc -l
	# echo "Number Of Excludes: $NumberOfExcludes"
}



## Main Program ##
SanityChecker
echo " "

#################################################################################################
# Command Breakdown #										#
#################################################################################################

# grep -vE: Selects lines that do not match the extended regular expression.
#
# '^\s*(#|$)': Matches any line starting with zero or more spaces/tabs followed by either a comment symbol (#) or the end of the line (blank/empty line).
#
# wc -l: Counts the remaining lines.

