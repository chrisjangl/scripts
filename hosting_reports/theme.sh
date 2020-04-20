# update parent theme, record in git and report
# v1.0

# our variables
STAGING=~/public_html/staging
LIVE=~/public_html/clients
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1


function get_parent_theme {
    local parent_theme=$(wp --allow-root theme list --status=parent --field=name)
    echo "$parent_theme"

}

function get_parent_theme_version {
    local parent_theme_version=$(wp --allow-root theme list --status=parent --field=version)
    echo "$parent_theme_version"

}

function get_parent_theme_title {
    local parent_theme_title=$(wp --allow-root theme list --status=parent --field=title)
    echo "$parent_theme_title"
}

function update_parent_theme {
    echo "We will now update parent theme..."
    echo "..."
    local parent_theme=$(get_parent_theme)

    wp --allow-root theme update $parent_theme | tee -a reports/theme_update.log

    echo "Parent theme update signing off..."
    
}

function check_latest_update_version {
    local latest_version=$(wp --allow-root core check-update --field=version)

    echo "$latest_version"
}

function report_on_theme_updates {
    # if update was successful

    # delete last month's report, if it exists
    if [ -f "reports/theme.txt" ]; then
        rm reports/theme.txt
    fi

    # get parent theme name & version
    local parent_theme_version=$(get_parent_theme_version)
    local parent_theme_title=$(get_parent_theme_title)
    echo "$(printf "Parent theme ($parent_theme_title) is up to date (v$parent_theme_version)")" > reports/theme.txt
    echo "$(printf "Parent theme ($parent_theme_title) is up to date (v$parent_theme_version)")" > reports/theme.txt

    echo "-----------"
    echo "We have reported that the parent theme is up to date; however, as of right now, there is no check whether that is actually true."
    echo "You may want to check the output above, or you can check the update logs: ./reports/theme_update.log"
    echo "Update Reports signing off..."
}

function commit_parent_theme_update {
    # to-do: only run this if WordPress version is different from when we start
    # if update was successful...

    local parent_theme=$(get_parent_theme)
    local parent_theme_version=$(get_parent_theme_version)
    local parent_theme_title=$(get_parent_theme_title)

    echo "We will now add and commit the parent theme update..."
    echo "..."
    git add wp-content/themes/$parent_theme
    git commit -m "$(printf "update theme: $parent_theme_title -> $parent_theme_version")"

    echo "git signing off..."

}

# function check_theme_update {

# }

# let's get started
clear

echo "We'll be updating the parent theme in $DIRECTORY here. Let's get started. "
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


parent_theme_title=$(get_parent_theme_title)
parent_theme_version=$(get_parent_theme_version)
echo "Parent theme ("$parent_theme_title") is currently at version: " $parent_theme_version

# update WordPress
echo "Passing off to update parent theme..."
echo "..."
update_parent_theme

# add to reports
echo "Passing off to report our actions..."
echo "..."
report_on_theme_updates

# add to git
echo "Passing off to commit to git..."
echo "..."
commit_parent_theme_update

# close up shop
echo "-----------------------------------------------------------"
echo "We just attempted to update the parent theme in" $DIRECTORY
echo "We ran through each step. No guarantees as to success, and there have been no fail-safes"
echo "Adios."