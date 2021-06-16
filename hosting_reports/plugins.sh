# update plugins, record in git and report
# v1.0

# our variables
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1

function update_plugins {
    echo "We will now update active plugins..."
    echo "..."
    
    # delete previous report & log, if they exist
    if [ -f "reports/updated-plugins.txt" ]; then
        rm reports/updated-plugins.txt
    fi
    if [ -f "reports/plugin_updates.log" ]; then
        rm reports/plugin_updates.log
    fi

    for plugin in $(wp --allow-root plugin list --update=available --status=active --field=name);
    do
        TITLE=$(wp --allow-root plugin get $plugin --field=title)
        # look into how we can mark the date here. Maybe also only output final result
        wp --allow-root plugin update $plugin | tee -a reports/plugin_updates.log &&
        VERSION=$(wp --allow-root plugin get $plugin --field=version)
        git add -A wp-content/plugins/$plugin &&
        git commit -m "$(printf "update plugin: $TITLE to $VERSION")"
        echo "$TITLE -> $VERSION" >> ./reports/updated-plugins.txt
    done;

    echo "Plugin updates signing off..."
    
}

function skipped_plugins {
    echo "We will now report on skipped plugins..."
    echo "..."
    
    # delete previous report, if it exists
    if [ -f "reports/skipped-plugins.txt" ]; then
        rm reports/skipped-plugins.txt
    fi
    
    for plugin in $(wp --allow-root plugin list --update=available --status=inactive --field=name);
    do
        TITLE=$(wp --allow-root plugin get $plugin --field=title)
        echo "$TITLE -> Plugin not active - please remove if no longer in use" >> ./reports/skipped-plugins.txt
    done;

    echo "Skipped plugins report signing off..."
    
}

# let's get started
clear

echo "We'll be updating plugins in $DIRECTORY here. Let's get started. "
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