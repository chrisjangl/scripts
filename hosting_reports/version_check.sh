# checks the WordPress versions of all subdirectories
# creates a text & CSV file
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

# let's get started
clear

# cd to that folder
cd $SERVER

cd $DIRECTORY

core_version=$(get_current_core_version)

echo "-------------------" | tee -a $SERVER/versionReport.txt
echo "" | tee -a $SERVER/versionReport.txt
echo "$DIRECTORY" | tee -a $SERVER/versionReport.txt
echo "Version: $core_version" | tee -a $SERVER/versionReport.txt
echo "" | tee -a $SERVER/versionReport.txt
echo "-------------------" | tee -a $SERVER/versionReport.txt

echo "$DIRECTORY, $core_version" >> $SERVER/versionReport.csv
