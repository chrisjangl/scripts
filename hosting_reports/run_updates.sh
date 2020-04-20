#!/bin/bash
# run the scripts to update core, plugins, & theme
# v1.0

# our variables
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1



# let's get started
clear

echo "We'll be performing updates for WordPress core, active plugins & the parent theme in $DIRECTORY here. Let's get started. "
echo
echo "-----------------------------------------------------------"

# pass off to core.sh
echo "Passing off to core.sh....."
echo "..."
bash core.sh $DIRECTORY

# pass off to plugins.sh
echo "-----------------------------------------------------------"
echo "Passing off to plugins.sh"
echo "..."
bash plugins.sh $DIRECTORY

# pass off to theme.sh
echo "-----------------------------------------------------------"
echo "Passing off to theme.sh"
echo "..."
bash theme.sh $DIRECTORY

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to update WordPress core, active plugins & the parent theme in $DIRECTOR"
echo "We ran through each step. No guarantees as to success, and there have been no fail-safes."
echo "Adios."