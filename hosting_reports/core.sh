# update WordPress core, record in git and report
# v1.0

# our variables
STAGING=~/public_html/staging
LIVE=~/public_html/clients
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1



function get_current_core_version {
    local core_version=$(wp --allow-root core version)
    echo "$core_version"
}

function update_core {
    echo "We will now update WordPress..."
    echo "..."
    wp --allow-root core update | tee -a reports/core_update.log

    echo "WordPress update signing off..."
    
}

function check_latest_update_version {
    local latest_version=$(wp --allow-root core check-update --field=version)

    echo "$latest_version"
}

function report_on_wordpress_updates {
    # if update was successful

    # delete last month's report, if it exists
    if [ -f "reports/core.txt" ]; then
        rm reports/core.txt
    fi
    echo "WordPress is up to date (v$(wp --allow-root core version))" > reports/core.txt
    

    echo "-----------"
    echo "We have reported that WordPress is up to date; however, as of right now, there is no check whether that is actually true."
    echo "You may want to check the output above, or you can check the update logs: ./reports/core_update.log"
    echo "Update Reports signing off..."
}

function commit_wordpress_updates {
    # to-do: only run this if WordPress version is different from when we start
    # if update was successful...
    echo "We will now add and commit the WordPress updates..."
    echo "..."
    git add wp-admin/
    git add wp-includes/
    git add *.*
    git commit -m "update WordPress -> $(wp --allow-root core version)"

    echo "git signing off..."

}

# function check_theme_update {

# }

# let's get started
clear

echo "We'll be updating WordPress $DIRECTORY here. Let's get started. "
echo

# echo "Here is a list of the directories we have availabe to work with: "
# echo
# echo "-----------------------------------------------------------"

# list the directories available and ask which to work on
cd $SERVER
# ls
# echo "-----------------------------------------------------------"

# echo
# read -p "REMINDER: We are about to work on $SERVER - which directory are we backing up right now? " -e SITEFOLDER

# cd to that folder
cd $DIRECTORY


core_version=$(get_current_core_version)
echo "WordPress is currently at version: " $core_version

# update WordPress
echo "Passing off to update WordPress..."
echo "..."
update_core

# add to reports
echo "Passing off to report our actions..."
echo "..."
report_on_wordpress_updates

# add to git
echo "Passing off to commit to git..."
echo "..."
commit_wordpress_updates

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to update WordPress core in" $DIRECTORY
echo "We ran through each step. No guarantees as to success, and there have been no fail-safes"
echo "Adios."