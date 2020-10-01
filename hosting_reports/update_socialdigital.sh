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

# we'll need to ask for the current month to pass in as the second argument
read -p "HEY: What month are we working on/for/in? " -e MONTH

echo "We'll be performing updates for WordPress core, active plugins & the parent theme on all Social Digitally hosted sites. Let's get started. "
echo
echo "-----------------------------------------------------------"

for site in $(cat sites.txt )
do 
    echo "We're about to run the updates on $site."
    # we'll need to ask for the current month to pass in as the second argument
    bash run_updates.sh $site $MONTH
done;

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to update WordPress core, active plugins & the parent theme in $DIRECTOR"
echo "We ran through each step. No guarantees as to success, and there have been no fail-safes."
echo "Adios."