# update plugins, record in git and report
# v1.0

# our variables
SERVER="/mnt/c/MAMP/htdocs"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1



# let's get started
clear

echo "We'll be performing updates in $DIRECTORY here. Let's get started. "
echo
echo "-----------------------------------------------------------"

# pass off to core.sh


# echo "Here is a list of the directories we have availabe to work with: "
# echo
# echo "-----------------------------------------------------------"

# list the directories available and ask which to work on
cd $SERVER
# ls
# echo "-----------------------------------------------------------"

# echo
# read -p "REMINDER: We are about to work on $SERVER - which directory are we updating up right now? " -e SITEFOLDER

# cd to that folder
cd $DIRECTORY


# update active plugins
echo "Passing off to update plugins..."
echo "..."
update_plugins

# add list of skipped plugins to reports
echo "Passing off to report the plugins we skipped..."
echo "..."
skipped_plugins

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to update the active plugins in" $DIRECTORY
echo "We ran through each step. No guarantees as to success, and there have been no fail-safes."
echo "Adios."