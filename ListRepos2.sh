# List repos
# dnf5 repo list --enabled | awk '{print $1}' | grep -v '^$'

### Enable Cecho ###
function EnableCecho() {
        CechoFile="./Cecho.bfunc"
        if [  -f $CechoFile ]; then
                source $CechoFile
                cecho green "Cecho Enabled."
        else
                echo "ERROR! Cecho Library File $CechoFile NOT Found..."
                return 1
        fi
}


function ListEnabledRepos() {
        echo " "
        cecho white "------------------------------"
        cecho green "ENABLED Repository List"
        cecho white "------------------------------"
        # echo " "

# List repos without first line that says 'Repo' (uses NR>1 in awk vs print $1)
        dnf5 repo list --enabled | awk 'NR>1 {print $1}'
}

function ListDisabledRepos() {
        echo " "
        cecho white "------------------------------"
        cecho red "DISABLED Repository List"
        cecho white "------------------------------"
        # echo " "

 # List repos without first line that says 'Repo' (uses NR>1 in awk vs print $1)
        dnf5 repo list --disabled | awk 'NR>1 {print $1}'
}


## Added May 21 2026 ###
functions ListAllRepos() {
        ListEnabledRepos
        ListDisabledRepos
}

#################################################################################
# TODO List #                                                           #
#################################################################################

# TODO: Create CASE statement w/ ListEnabledRepos as default.  Include help option.

# FIXME: Cecho is old copy from Nov 2024 / Shows help when run.

# TODO: Option to list both enabled and disabled repos at same time (Case Statement).

##################################################################################



#################################################################################
# Main Program #                                                                #
#################################################################################

EnableCecho
ListEnabledRepos

# ListDisabledRepos
