#!/bin/bash
# for each local SD site (as listed in ./sites.txt),
# update plugins, WordPress & parent theme, record in git and report
# v1.0

# our variables
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1



# let's get started
clear

echo "We'll be looping through the sites in Social Digital and getting them ready for updates. Let's get started. "
echo
echo "-----------------------------------------------------------"

for site in $(cat sites.txt )
do 
    echo "We're about to do some stuff with git on $site."
    # read -p "Press enter to continue..."
    cd $SERVER/$site
    git checkout master
    git pull
done;

# close up shop
# echo "-----------------------------------------------------------"
# echo "We just attempted to update WordPress core, active plugins & the parent theme in $DIRECTOR"
# echo "We ran through each step. No guarantees as to success, and there have been no fail-safes."
echo "Adios."