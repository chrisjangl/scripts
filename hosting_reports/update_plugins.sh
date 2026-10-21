#!/bin/zsh
# update plugins, record in git and report
# v1.0

# our variables
SERVER="/Users/chris/sites"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}
DIRECTORY=$1

# optional per-site testing, from the site's Wordpress-updates/ repo - run with SKIP_TESTS=1 to bypass
TESTS="Wordpress-updates/bin"
if [ ! -f "$TESTS/quick-check.mjs" ]; then
    export SKIP_TESTS=1
fi

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

    for plugin in $(wp --allow-root plugin list --update=available --status=active --field=name 2>/dev/null);
    do
        TITLE=$(wp --allow-root plugin get $plugin --field=title)
        OLD_VERSION=$(wp --allow-root plugin get $plugin --field=version)
        # look into how we can mark the date here. Maybe also only output final result
        wp --allow-root plugin update $plugin | tee -a reports/plugin_updates.log &&
        VERSION=$(wp --allow-root plugin get $plugin --field=version)

        # stop at the first plugin that breaks the site, leaving it uncommitted for inspection
        if [ -z "$SKIP_TESTS" ] && ! node $TESTS/quick-check.mjs; then
            echo "$TITLE ($OLD_VERSION -> $VERSION) broke the site - not committed, remaining updates skipped" | tee ./reports/failed-plugins.txt
            echo "To roll back: git checkout -- wp-content/plugins/$plugin && git clean -fd wp-content/plugins/$plugin"
            echo "              and, if it changed the database, wp db import the latest reports/pre-update_*.sql"
            break
        fi

        git add -A wp-content/plugins/$plugin &&
        git commit -m "$(printf "update plugin: $TITLE $OLD_VERSION -> $VERSION")"
        echo "$TITLE ($OLD_VERSION -> $VERSION)" >> ./reports/updated-plugins.txt
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
    
    for plugin in $(wp --allow-root plugin list --update=available --status=inactive --field=name 2>/dev/null);
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

# cd to that folder
# cd $SERVER

# cd $DIRECTORY

## create the reports directory if it doesn't already exist
if [ ! -d ./reports ] 
then 
    mkdir reports/
fi

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