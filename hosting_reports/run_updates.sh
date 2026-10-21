#!/bin/zsh
# run the scripts to update core, plugins, & theme
# need to pass a diretory against which to run the updates
# v1.0

# our variables
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1
MONTH=$2

# optional per-site testing, from the site's Wordpress-updates/ repo - run with SKIP_TESTS=1 to bypass
TESTS="Wordpress-updates/bin"
if [ ! -f "$TESTS/quick-check.mjs" ]; then
    export SKIP_TESTS=1
fi


# let's get started
clear
# git commit -m "$(date +%B) reports"

## create the reports directory if it doesn't already exist
if [ ! -d ./reports ] 
    then 
        mkdir reports/
    fi

echo "We'll be performing updates for WordPress core, active plugins & the parent theme in $DIRECTORY here. Let's get started. "
echo
echo "-----------------------------------------------------------"

# backup & baseline before touching anything
if [ -z "$SKIP_TESTS" ]; then
    bash $TESTS/pre-update.sh || exit 1
fi

# pass off to core.sh
echo "Passing off to core.sh....."
echo "..."
bash update_core.sh $DIRECTORY

if [ -z "$SKIP_TESTS" ] && ! node $TESTS/quick-check.mjs; then
    echo "The WordPress core update broke the site - stopping before plugins & theme."
    exit 1
fi

# pass off to plugins.sh
echo "-----------------------------------------------------------"
echo "Passing off to plugins.sh"
echo "..."
bash update_plugins.sh $DIRECTORY

# pass off to theme.sh
echo "-----------------------------------------------------------"
echo "Passing off to theme.sh"
echo "..."
bash update_theme.sh $DIRECTORY

# test the updated site
if [ -z "$SKIP_TESTS" ]; then
    echo "-----------------------------------------------------------"
    echo "Running the full test suite..."
    bash $TESTS/post-update.sh
fi

# commit reports for the month
echo "-----------------------------------------------------------"
echo "Commiting reports"
echo "..."
# bash commit_reports.sh $DIRECTORY $MONTH

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to update WordPress core, active plugins & the parent theme in $DIRECTOR"
echo "We ran through each step. No guarantees as to success, and there have been no fail-safes."
echo "Adios."