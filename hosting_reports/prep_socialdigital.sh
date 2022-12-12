#!/bin/bash
# for each local SD site (as listed in ./sites.txt),
# prep the directorty: clean up git & create new branch

####
# @todo: need to make sure that I'm currently on a monthly update branch
# @todo: need to account for master needing to pull changes from remote
####
# v1.0

# our variables
SERVER="/Users/chris/sites/"
DATE=$(date +%Y-%m-%d)
YEAR=$(date +%Y)
MONTH=$(date +%m)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1



# let's get started
clear

# we'll need to ask for the current month to pass in as the second argument
echo
echo "-----------------------------------------------------------"

for SITE in $(cat sites.txt)
do 
    cd $SERVER
    cd $SITE

    echo "========================="
    echo $SITE
    echo "========================="
    
    ## check if there are any uncommitted changes
    if output=$(git status --porcelain) && [ -z "$output" ]; then
        # Working directory clean 
        # checkout master
        echo "--------"
        echo "Checking out production..."
        git checkout production
        echo "--------"

        # pull latest PR
        echo "--------"
        echo "pulling latest changes..."
        git pull
        echo "--------"

        # make sure we're still riding clean

        # create new update branch - updates/<yyyyy>/<mm>
        echo "--------"
        echo "creating new update branch..."
        git checkout -b updates/$YEAR/$MONTH
        echo "--------"

        # publish the branch to github remote
        # git push --set-upstream github $(git branch | grep \* | cut -b 3-) 
        
        
        # git push --set-upstream github $(git branch | grep \* | cut -b 3-) 
        # and finally create new branch for this month's updates
        # git checkout -b updates/$(date +%Y)/$(date +%m)
    else 
    # Uncommitted changes
        echo "Looks like there are uncommited changes on this site"
    fi
    # we'll need to ask for the current month to pass in as the second argument
    
done;

# close up shop
echo "-----------------------------------------------------------"
echo "We just went to each site and attempted to pull latest changes, create new update branch."
echo "Adios."