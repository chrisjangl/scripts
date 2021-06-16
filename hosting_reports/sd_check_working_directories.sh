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

for site in $(cat sites.txt )
do 
    cd $SERVER
    cd $site
    # echo "We're about to run the updates on $site."
    # we'll need to ask for the current month to pass in as the second argument
    bash is_working_directory_clean.sh
done;

