# commit hosting reports to git repo
# v1.0

# our variables
STAGING=~/public_html/staging
LIVE=~/public_html/clients
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1
MONTH=$2

# let's get started
clear

echo "We'll be committing the reports for $DIRECTORY here. Let's get started. "
echo

# change to MAMP directory
# cd $SERVER

# cd to the site folder
# cd $DIRECTORY

# @TODO: we should clear the working directory first, no?
# add the reports/ dir to the working directory
git add ./reports/

# determine the commit message (spec. the month)
# read -p "HEY: What month are these reports for? " -e MONTH

# commit the reports
git commit -m "$MONTH reports"

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to commit the reports for " $DIRECTORY
echo "We ran through each step. No guarantees as to success, and there have been no fail-safes"
echo "Adios."