#!/bin/env bash

# List repos
# dnf5 repo list --enabled | awk '{print $1}' | grep -v '^$'

#################################################################################
# List Functions #                                                              #
#################################################################################

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
function ListAllRepos() {
        ListEnabledRepos
        ListDisabledRepos
}

#################################################################################
# Help Function #                                                               #
#################################################################################

show_help() {
    echo "Usage: $(basename "$0") [option]"
    echo ""
    echo "Options:"
    echo "  -h, --help       Show this help message and exit"
    echo "  -l, --list       List all enabled repositories (Default action)"
    echo "  -a, --all        Show all repositories (example placeholder)"
    echo "  -e, --enabled    List enabled repositories"
    echo "  -d, --disabled   List Disabled repositories"
    echo ""
    echo "If no option is provided, it defaults to listing enabled repositories."
}



#################################################################################
# CASE Statement #                                                              #
#################################################################################

# Main execution logic using a case statement
# $1 represents the first command-line argument passed to the script
case "$1" in
    -h|--help)
        show_help
        exit 0
        ;;
    -l|--list)
        ListEnabledRepos
        ;;
    -a|--all)
        ShowAllRepos
        ;;
    -e|--enabled)
        ListEnabledRepos
        ;;
    -d|--disabled)
        ListDisabledRepos
        ;;
    "")
        # Matches when no argument is provided at all
        echo "No option provided. Defaulting to ListEnabledRepos."
        ListEnabledRepos
        ;;
    *)
        # Matches any undefined or unexpected options
        echo "Error: Invalid option '$1'" >&2
        show_help
        exit 1
        ;;
esac




#################################################################################
# Main Program #                                                                #
#################################################################################

EnableCecho
ListEnabledRepos

# ListDisabledRepos
# ListAllRepos
