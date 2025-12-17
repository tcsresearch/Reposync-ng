## Define Variables ##

# Reposync Feature #
# TODO: Enable config for below parameter.
# 	dnf reposync = DNF 5
# 	reposync     = DNF 4
Legacy_RepoSync_Enabled="0"

prog="dnf reposync" # Can be either 'reposync' or dnf reposync'
args=" -n -m --delete"
debug=" --debug" # use this to debug reposync when there are issues.

# Excludes Feature #
# excludes="*debug*,*-langpack-*,*-source-*,*-src-*,*-headless-*,*-langpack-*,libreoffice-help-*"
Repo_Excludes="$(cat excludes-filtered.list)" # Initial value to prevent file not found error.
RepoID="fedora"

# File Filtering Feature #
  FILE_PATH="excludes.list"
  FILTERED_FILE="excludes-filtered.list"


#----------------------------------------------------------------------------------------------------------------------------------#

function DisplayBanner() {
	echo "RepoSync Utility."
	echo " "
	# Display Date Modified of excludes.list
	### echo "Excludes File Date: `date -r $FILE_PATH"`
	echo "Excludes File Date: `date -r $FILTERED_FILE`"
}	

function SanityCheck_IsExcludesNotEmpty() {
	if [ -z "$Repo_Excludes" ]; then
	   echo "Error: Excludes Variable '$Repo_Excludes' is empty. Script terminated."
    	   exit 1
	fi
}

function FilterExcludesFile() {
# File Filtering Feature #
###	FILE_PATH="excludes.list"
###	FILTERED_FILE="excludes-filtered.list"

	# Filter contents of $FILE_PATH into $FILTERED_FILE
	echo "Filtering contents of excludes file $FILE_PATH..."
	# cat $FILE_PATH | grep -Ev '^[[:blank:]]*#|^[[:blank:]]*$' filename.txt
	grep -Ev '^[[:blank:]]*#|^[[:blank:]]*$' $FILE_PATH > $FILTERED_FILE


	# Modern Bash method using input redirection (recommended)
	echo "Saving Filtered Contents Of File $FILTERED_FILE to excludes variable..."
	# FILE_CONTENT=$(<"$FILE_PATH")
	FILE_CONTENT=$(<"$FILTERED_FILE")
	
	# Modern Bash method using input redirection (recommended)
	excludes=$(<"FILTERED_FILE")
}

function CleanMetaData() {
	echo "Cleaning Metadata..."
	sudo dnf clean metadata
	echo " "
}

function PerformRepoSync() {
# Perform Repo Sync #
	# $prog $args --repoid=updates --exclude=*debug*,*-langpack-*,*-source-*,*-src-*,*-headless-*,*-langpack-*,libreoffice-help-*,
	$prog $args --repoid=$RepoID --exclude='$Repo_Excludes'
}



function RemoveFilteredFile() {
# Remove $FILTERED_FILE
	echo "Removing Filtered File $FILTERED_FILE..."
	rm $FILTERED_FILE
}

#----------------------------------------------------------------------------------------------------------------------------------#
# Main Program #

DisplayBanner
# FilterExcludesFile
CleanMetaData
SanityCheck_IsExcludesNotEmpty
PerformRepoSync
# RemoveFilteredFile

