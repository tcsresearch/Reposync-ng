
function Usage () {
	echo "Error: No source folder specified for sourcing."
        echo "Usage: $0 <source_directory>"
        echo "       <source_directory> is usually one of the following: config | functions | profiles."
        echo " "
###        exit 1 # Exit with a non-zero status to indicate an error
}

function PreLoad() {


	## Show usage if no arguments specified.
	# if [ -z "$1" ]; then
##	 if [ "$#" -eq 0 ]; then
## 	    Usage
##       fi

	

	## Define the directory containing the scripts
	# SOURCE_DIR="./my_scripts_folder" 
	# SOURCE_DIR="/etc/bashrc.d/PS1ConfigTool/functions"

	## Set $1 to match $SOURCE_DIR.
 	SOURCE_DIR="$1"

	## Echo $SOURCE_DIR.
	echo "Source Folder: $SOURCE_DIR"

	## Loop through all files in the specified directory
	for file in "$SOURCE_DIR"/*.$extension; do
	  # Check if the file is a regular file and not a directory
	  if [ -f "$file" ]; then
	    echo "Sourcing File: $file"
	    # Source the file
	    source "$file"
	    echo "File Sourced: $file"
	  fi
	done
# }

# function ShowCase() {
	case "$1" in
		config)
			echo "Loader Type: config"
			echo "Loader Dir:  $SOURCE_DIR"
			echo "Extension:   $extension"
			SOURCE_DIR="./config"
			extension=".conf"      	
			PreLoad config	
                	;;
        	functions)
			echo "Loader Type: functions"
                        echo "Loader Dir:  $SOURCE_DIR"
                        echo "Extension:   $extension"
                	SOURCE_DIR="./functions"
			extension=".bfunc"
			PreLoad functions
                	;;
		profiles)
			echo "Loader Type: profiles"
                        echo "Loader Dir:  $SOURCE_DIR"
                        echo "Extension:   $extension"
			SOURCE_DIR="./profiles"
			extension=".bprofile"
			PreLoad profiles
			;;
		*) # Default Case
			Usage
			;;
	esac
 }

## Run ##
PreLoad
# ShowCase

