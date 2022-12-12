#!/bin/bash
# for each local SD site (as listed in ./sites.txt),
# prep the directorty: clean up git & create new branch

####
# @todo: need to make sure that I'm currently on a monthly update branch
# @todo: need to account for master needing to pull changes from remote
####
# v1.0

# our variables
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1



# let's get started
clear

# we'll need to ask for the current month to pass in as the second argument
echo "We'll be listing the branches in each repo. Let's get started. "
echo
echo "-----------------------------------------------------------"

for SITE in $(cat sites.txt )
do 
    cd $SERVER
    cd $SITE
    ## check if there are any uncommitted changes
    clear
    echo "Here are the branchs on $SITE: "
    git branch
    read -n1 -s -r -p $'Press space to continue...\n' key
    
done;

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to update WordPress core, active plugins & the parent theme in $DIRECTORY"
echo "Adios."