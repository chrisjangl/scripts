#!/bin/bash

# Define variables
SCRIPT_DIR="/Users/chrisjangl/Local Sites/wine-enthusiast/app/public"
LOCAL_ROOT="$SCRIPT_DIR/"
LOCAL_THEME_DIR="wp-content/themes/understrap-child/"
EXCLUDE_FILE="${LOCAL_ROOT}bitbucket-deploy-exclude-patterns"
REMOTE_USER="unifiedwinedev"
REMOTE_HOST="unifiedwinedev.ssh.wpengine.net"
REMOTE_ROOT="/sites/unifiedwinedev/"
REMOTE_THEME_DIR="/sites/unifiedwinedev/wp-content/themes/understrap-child/"

# build theme CSS & JS
cd $LOCAL_THEME_DIR
echo "Step 1."
echo "Building theme CSS & JS..."
# npm install
# npm run dist
echo "Theme CSS & JS built."
echo "=============================="

# install PHP dependencies, via Composer
echo "Step 2."
echo "Installing PHP dependencies..."
# composer install
echo "PHP dependencies installed."
echo "=============================="

# prep deploy to WP Engine
# Change back to the original directory
cd ../../../

# Debugging: Print the current working directory and the exclude file path
echo "Current working directory: $(pwd)"
echo "Expected exclude file path: $EXCLUDE_FILE"

# Check if the exclude file exists
if [ ! -f "$EXCLUDE_FILE" ]; then
    echo "Exclude file $EXCLUDE_FILE does not exist."
    exit 1
fi

# Run rsync
echo "Step 3."
echo "Deploying to WP Engine..."
# rsync -avz --delete $LOCAL_THEME_DIR $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR
# rsync -avz --delete $EXCLUDE_PARAMS $REMOTE_USER@$REMOTE_HOST:$REMOTE_ROOT $LOCAL_ROOT
rsync -avz --delete --exclude-from="$EXCLUDE_FILE" $LOCAL_ROOT ssh.we-dev:$REMOTE_ROOT
# ssh ssh.we-dev

echo "Deployment complete."
echo "=============================="