# List repos
# dnf5 repo list --enabled | awk '{print $1}' | grep -v '^$'


function ListEnabledRepos() {
        echo " "
        echo "---------- ENABLED Repository List ----------"
        # echo " "

# List repos without first line that says 'Repo' (uses NR>1 in awk vs print $1)
        dnf5 repo list --enabled | awk 'NR>1 {print $1}'
}

function ListDisabledRepos() {
        echo " "
        echo "---------- DISABLED Repository List ----------"
        # echo " "

 # List repos without first line that says 'Repo' (uses NR>1 in awk vs print $1)
        dnf5 repo list --disabled | awk 'NR>1 {print $1}'
}

#################################################################################
# Main Program #                                                                #
#################################################################################

# TODO: Create CASE statement w/ ListEnabledRepos as default.  Include help option.

# TODO: Enable Cecho and use different colors for enabled and disabled repos.

# TODO: Option to list both enabled and disabled repos at same time.

ListEnabledRepos
