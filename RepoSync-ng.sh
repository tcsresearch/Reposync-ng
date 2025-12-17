# Before we do anything, we MUST run our PreLoader!
 source ./AdvPreLoader.sh
 echo " "



# Display Banner
DisplayBanner

# Sanity Checks
Perform_SanityChecks

# Parse Config Options
Perform_ConfigOptsParse

# Present Options
ShowCase

# Filter Excludes File
FilterExcludesFile

### Main Operation ###
# Run RepoSync
PerformRepoSync
