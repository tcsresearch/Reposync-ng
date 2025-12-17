## Define Variables ##

# Reposync Feature #
prog="reposync"
args=" -n -m --delete"
debug=" --debug" # use this to debug reposync when there are issues.

# Excludes Feature #
# excludes="*debug*,*-langpack-*,*-source-*,*-src-*,*-headless-*,*-langpack-*,libreoffice-help-*"
excludes="$(cat excludes.list)" # Initial value to prevent file not found error.
RepoID="fedora"

# File Filtering Feature #
  FILE_PATH="excludes.list"
  FILTERED_FILE="excludes-filtered.list"


#----------------------------------------------------------------------------------------------------------------------------------#

# Display Date Modified of excludes.list
echo "Excludes File Date: `date -r $FILE_PATH"`


function FilterExcludesFile() {
# File Filtering Feature #
	FILE_PATH="excludes.list"
	FILTERED_FILE="excludes-filtered.list"

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


function PerformRepoSync() {
# Perform Repo Sync #
	# $prog $args --repoid=updates --exclude=*debug*,*-langpack-*,*-source-*,*-src-*,*-headless-*,*-langpack-*,libreoffice-help-*,
	$prog $args --repoid=$RepoID --exclude='$excludes'
}



#----------------------------------------------------------------------------------------------------------------------------------#
# Main Program #

FilterExcludesFile
# PerformRepoSync


