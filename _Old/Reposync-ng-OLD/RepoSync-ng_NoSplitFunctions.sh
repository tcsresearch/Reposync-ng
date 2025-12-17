####################################################################################################################################
# Source Config #                                                                                                                      #
####################################################################################################################################

ConfigDir="./config"
ConfigFile="RepoSync-ng.conf"

# Sanity Check #
 if [ -f $ConfigDir/$ConfigFile ]; then
	 echo "Sourcing Configuration..."
	 source $ConfigDir/$ConfigFile
 else
	 echo "ERROR! Configuration File $ConfigFile Not Found in $ConfigDir."
	 exit 1
 fi

####################################################################################################################################
# Source Functions #                                                                                                                      #
####################################################################################################################################

FuncDir="$(pwd)"
FuncFile="RepoSync-ng.bfunc"

# Sanity Check #
 if [ -f $FuncDir/$FuncFile ]; then
         echo "Sourcing Functions..."
         source $FuncDir/$FuncFile
 else
         echo "ERROR! Function File $FuncFile Not Found in $FuncDir."
         exit 1
 fi


####################################################################################################################################
# Variables #                                                                                                                      #
####################################################################################################################################

#  excludes="*debug*,*-langpack-*,*-source-*,*-src-*,*-headless-*,*-langpack-*,libreoffice-help-*"
  Repo_Excludes="$(cat excludes-filtered.list)" # Initial value to prevent file not found error.

#  RepoID="fedora"
# Initialize blank $RepoID for use in CASE statement later 
  RepoID=""





####################################################################################################################################
# Functions #                                                                                                                      #
####################################################################################################################################

function DisplayBanner() {
	echo "RepoSync Utility."
	# Display Date Modified of excludes.list
	echo "Excludes File Date: `date -r $Excludes_FilePath/$Excludes_FileName`"
	echo " "
}	



function CfgDisplay() {
	# Define local variables for this function only.
	local Cfg_Description=" $1"
	local Cfg_Variable="$2"
	
	# Define format: Left-justify with specified widths, followed by a newline (\n)
	# %-15s: 15 chars wide, left-justified
	# %-10s: 10 chars wide, left-justified
	# %-5s: 5 chars wide, left-justified
        FORMAT="%-15s %-10s %-5s\n"


	printf "$FORMAT" "$Cfg_Description $Cfg_Variable" 
}


####################################################################################################################################
# Parse Config Options #                                                                                                           #
####################################################################################################################################


function ParseConfigOpts_LegacyRepoSyncEnabled() {
# TODO: Allow for capitalized variants of these.
        
	case "$Legacy_RepoSync_Enabled" in
           y|yes|true|enabled|on|1)
                echo "Legacy RepoSync is ENABLED."
		prog=reposync"
                ;;
           n|no|false|disabled|off|0)
                echo "Legacy RepoSync is DISABLED."
                prog=dnf reposync"

                ;;
           *) # Default Case
                echo "ERROR: Variable $Legacy_RepoSync_Enabled is either unset, or is configured incorrectly."
                echo "       Variable $Legacy_RepoSync_Enabled *must* be set to one of these: 'y|yes|true|enabled|on|1' or 'n|no|false|disabled|off|0' "
                echo " "
                ;;
        esac
}

function ParseConfigOpts_DebugEnabled() {
# TODO: Allow for capitalized variants of these.

        case "$Cfg_DEBUG_ENABLED" in
           y|yes|true|enabled|on|1)
                echo "Debugging is ENABLED."
                debug=" --debug"
                ;;
           n|no|false|disabled|off|0)
                echo "Debugging is DISABLED."
                debug=""

                ;;
           *) # Default Case
                echo "ERROR: Variable $Cfg_DEBUG_ENABLED is either unset, or is configured incorrectly."
                echo "       Variable $Cfg_DEBUG_ENABLED *must* be set to one of these: 'y|yes|true|enabled|on|1' or 'n|no|false|disabled|off|0' "
                echo " "
                ;;
        esac
}

function ParseConfigOpts_DeleteEnabled() {
# TODO: Allow for capitalized variants of these.

        case "$Cfg_DELETE_ENABLED" in
           y|yes|true|enabled|on|1)
                echo "Deletion is ENABLED."
                delete=" --delete"
                ;;
           n|no|false|disabled|off|0)
                echo "Deletion is DISABLED."
                delete=""

                ;;
           *) # Default Case
                echo "ERROR: Variable $Cfg_DELETE_ENABLED is either unset, or is configured incorrectly."
                echo "       Variable $Cfg_DELETE_ENABLED *must* be set to one of these: 'y|yes|true|enabled|on|1' or 'n|no|false|disabled|off|0' "
                echo " "
                ;;
        esac
}


function ParseConfigOpts_CleanMetaData() {
# TODO: Allow for capitalized variants of these.

        case "$Cfg_CLEAN_METADATA" in
           y|yes|true|enabled|on|1)
                echo "Metadata Cleaning is ENABLED."
                CleanMetaData
                ;;
           n|no|false|disabled|off|0)
                echo "Metadata Cleaning is DISABLED."
                ;;
           *) # Default Case
                echo "ERROR: Variable $Cfg_CLEAN_METADATA is either unset, or is configured incorrectly."
                echo "       Variable $Cfg_CLEAN_METADATA *must* be set to one of these: 'y|yes|true|enabled|on|1' or 'n|no|false|disabled|off|0' "
                echo " "
                ;;
        esac
}

function ParseConfigOpts_Download_MetaData() {
# TODO: Allow for capitalized variants of these.

        case "$Cfg_DOWNLOAD_METADATA" in
           y|yes|true|enabled|on|1)
                echo "Metadata Downloading is ENABLED."
                downloadmetadata=" -m"
                ;;
           n|no|false|disabled|off|0)
                echo "Metadata Downloading is DISABLED."
                downloadmetadata=" "
                ;;
           *) # Default Case
                echo "ERROR: Variable $Cfg_DOWNLOAD_METADATA is either unset, or is configured incorrectly."
                echo "       Variable $Cfg_DOWNLOAD_METADATA *must* be set to one of these: 'y|yes|true|enabled|on|1' or 'n|no|false|disabled|off|0' "
                echo " "
                ;;
        esac
}

##### IMPORTANT #####
# This MUST be the last function in this section, as it requires the preceding functions to be defined first.

function Perform_ConfigOptsParse() {
# Parse all configuration options easily with this function.
# TODO: Determine which order they should run in.

	ParseConfigOpts_LegacyRepoSyncEnabled
	ParseConfigOpts_DebugEnabled
	ParseConfigOpts_DeleteEnabled
	ParseConfigOpts_CleanMetaData
	ParseConfigOpts_Download_MetaData
}

####################################################################################################################################
# Sanity Checks #                                                                                                                  #
####################################################################################################################################

function SanityCheck_DoesExcludeFileExist() {
	if [ ! -f $$Excludes_FilePath/$Excludes_FileName ]; then
		echo "ERROR! Excludes File $Excludes_FilePath/$Excludes_FileName does not exist!"
		exit 1
	fi
}

function SanityCheck_DoesFilteredExcludeFileExist() {
        if [ ! -f $$Excludes_FilePath/$FilteredExcludes_FileName ]; then
                echo "ERROR! Excludes File $Excludes_FilePath/$FilteredExcludes_FileName does not exist!"
                exit 1
        fi
}


function SanityCheck_IsExcludesNotEmpty() {
	if [ -z "$Repo_Excludes" ]; then
	   echo "Error: Excludes Variable '$Repo_Excludes' is empty. Script terminated."
    	   exit 1
	fi
}

function SanityCheck_IsRepoIDNotEmpty(){
# Check if RepoID was set
	if [[ -z "$RepoID" ]]; then
    	   DisplayBanner
	   echo "Error: RepoID not provided."
    	   exit 1
	fi
}

##### IMPORTANT #####
# This MUST be the last function in this section, as it requires the preceding functions to be defined first.

function Perform_SanityChecks() {
# Run all sanity checks easily with this function.
# TODO: Determine which order they should run in.

	# Check Variables #
	  SanityCheck_IsExcludesNotEmpty
	  SanityCheck_IsRepoIDNotEmpty

	# Check Files #
	  SanityCheck_DoesExcludesFileExist
	  SanityCheck_DoesFilteredExcludesFileExist
}

####################################################################################################################################
# Show Excludes #                                                                                                                  #
####################################################################################################################################

function ShowExcludes() {
	echo "Displaying Excludes Entries Below..."
	echo " "
	echo "$Repo_Excludes"
        exit 2 # Prevent endless loop	
}

####################################################################################################################################
# Show Current Config #                                                                                                            #
####################################################################################################################################

function ShowConfig() {
        echo "Displaying Current Configuration..."
        echo " "
	echo "###################################################################"
	echo "# Excludes Files Info #                                           #"
	echo "###################################################################"
        CfgDisplay	"  Excludes File Path: 		$Excludes_FilePath"
	CfgDisplay	"  Excludes Filename: 		$Excludes_FileName"
	CfgDisplay	"  Filtered Excludes:	 	$FilteredExcludes_FileName"
        CfgDisplay	"  Excludes File Date:	 	`date -r $Excludes_FilePath/$Excludes_FileName`"
	echo " "
	echo "###################################################################"
	echo "# Configured Options #                                            #"
	echo "###################################################################"
	### TODO: Enable ColorEcho and have green for enabled and red for disabled.
	###           Must add code in the section where config options are parsed.
	CfgDisplay "  Keep Newest Only: 		$Cfg_KEEP_NEWEST_ONLY"
	CfgDisplay "  Download Metadata: 		$Cfg_DOWNLOAD_METADATA"
	CfgDisplay "  Delete Old Packages:		$Cfg_DELETE_ENABLED"
	CfgDisplay "  Debugging Enabled: 		$Cfg_DEBUG_ENABLED"
	CfgDisplay "  Clean Metadata:			$Cfg_CLEAN_METADATA"
	CfgDisplay "  Remove Filtered Excludes:		$Cfg_REMOVE_FILTERED_FILE"     
	echo " "
	exit 3 # Prevent endless loop
}



#####################################################################################################################################
# Filter Excludes #                                                                                                                 #
#####################################################################################################################################

function FilterExcludesFile() {
# File Filtering Feature #
# TODO: Figure out how we want to handle situations where $FilteredExcludesFile already exists.

	# Filter contents of $Excludes_File into $FilteredExcludes_FileName
	echo "Filtering contents of excludes file $Excludes_FileName..."
	# cat $Excludes_FileName | grep -Ev '^[[:blank:]]*#|^[[:blank:]]*$' filename.txt
	grep -Ev '^[[:blank:]]*#|^[[:blank:]]*$' $Excludes_FileName > $FilteredExcludes_FileName


	# Modern Bash method using input redirection (recommended)
	echo "Saving Filtered Contents Of File $FilteredExcludes_FileName to excludes variable..."
	# FILE_CONTENT=$(<"$FILE_PATH")
	Excludes_FileName=$(<"$FilteredExcludes_FileName")
	
	# Modern Bash method using input redirection (recommended)
	Repo_Excludes=$(<"FilteredExcludes_FileName")
}


#####################################################################################################################################
# Clean Metadata - Called only if $Cfg_CLEAN_METADATA is set to ENABLED #                                                           #
#####################################################################################################################################

function CleanMetaData() {
	echo "Cleaning Metadata..."
	sudo dnf clean metadata
	echo " "
}

#####################################################################################################################################
# Remove Filtered File - Called only if $Cfg_REMOVE_FILTERED_FILE is set to ENABLED #                                               #
#####################################################################################################################################

function RemoveFilteredFile() {
# Remove $FilteredExcludes_FileName
	echo "Removing Filtered File $FilteredExcludes_FileName..."
	rm $FilteredExcludes_FileName
}




#####################################################################################################################################
# Perform RepoSync #                                                                                                                #
#####################################################################################################################################

function PerformRepoSync() {
# Perform Repo Sync #
        # $prog $args --repoid=updates --exclude=*debug*,*-langpack-*,*-source-*,*-src-*,*-headless-*,*-langpack-*,libreoffice-help-*,
        $prog $args --repoid=$RepoID --exclude='$Repo_Excludes'
}





####################################################################################################################################
# CASE Statement - Check Commandline Arguments #                                                                                   #
####################################################################################################################################

# Loop through command-line arguments
while [[ "$#" -gt 0 ]]; do
	# Use a case statement to check the argument
	case "$1" in
	  --repoid=*)
            # Pattern match to extract the value after "--repoid="
            RepoID="${1#--repoid=}"
            echo "RepoID set to: $RepoID"
            shift # Shift one argument as the value is part of $1
            ;;
	  --show-config)
	    ShowConfig 
	    ;;
	  --show-excludes)
	    ShowExcludes
	    ;;
	  --debug)
	    # TODO: Confirm this can't be overriden by config option.
	    Cfg_DEBUG_ENABLED="1"
	    ;;
	  --legacy)
	    # TODO: Confirm this can't be overriden by config option.
	    Legacy_Reposync_Enabled="1"
	    ;;
	  --help)
	    DisplayBanner    
	    echo "Usage: $0 [--show-config | --show-excludes] [--repoid=< name of repo to sync >]"
	    exit 1
	    ;;
    	  *)
	   # Handle other arguments or unknown options
            echo "Unknown argument: $1"
            shift
            ;;	  
	esac
done

####################################################################################################################################
# Main Program #                                                                                                                   #
####################################################################################################################################

# DisplayBanner
# FilterExcludesFile
### CleanMetaData

# Sanity Checks
Perform_SanityChecks

### These lines can be safely removed once testing is completed. ###
### SanityCheck_IsExcludesNotEmpty
### SanityCheck_IsRepoIDNotEmpty
### SanityCheck_DoesExcludesFileExist
### SanityCheck_DoesFilteredExcludesFileExist

# Parse Config Options #
Perform_ConfigOptsParse



# PerformRepoSync
### RemoveFilteredFile

