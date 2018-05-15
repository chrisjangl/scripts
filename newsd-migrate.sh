# Social Digital - Migrate live to staging

# our variables
SERVER="public_html/staging"
# SERVER="/mnt/c/MAMP/htdocs"
BU_FOLDER="dc_bu"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)

function has_db_export {
    has_db=$(find . -maxdepth 1 -name "*.sql" | wc -l)
    if [ $has_db -gt 0 ];
    then
        return 0
    else
        return 1
    fi
}

function get_db_credentials {
    clear

    echo "First, we need to get some information about the database we will be restoring TO. "
    echo

    echo "Remember, we're currently working with: "
    echo
    echo
    echo "-----------------------------------------------------------"
    echo "${SITEFOLDER}"
    echo "-----------------------------------------------------------"
    echo
    echo
    echo

	read -p "What is the database name? " -e DBNAME
	read -p "Thanks. What is the username to access $DBNAME? " -e DBUSER
	read -p "Cool. And lastly, what is the password for $DBUSER? " -e DBPASS

}

# let's get started
# clear the screen
clear

echo "Let's get started!"
echo

echo "Here is a list of the directories we can work with: "
echo
echo "-----------------------------------------------------------"

# list the directories available and ask which to work on
ls
echo "------------------------------------------------------------"
echo

echo 
read -p "REMINDER: We are about to work on $SERVER - which directory are we looking to RESTORE TO? " -e SITEFOLDER

# cd to that folder
cd $SITEFOLDER
cd wp-content


# check if the site folder has any back-up sets
if [ ! -d $BU_FOLDER ]; then
    echo "Sorry, it doesn't look like there are any back-up sets to restore from."
    echo
    exit 1
fi
# and cd there if it does
cd $BU_FOLDER

# clear the screen
clear
echo "OK. We'll be working with: "
echo 
echo
echo
echo $SITEFOLDER
echo
echo
echo

# show the back-up sets we have available and find out which to work with
echo "There are the back-up sets we have available in $SITEFOLDER: "
echo
echo "------------------------------"
# list the back-up sets we have on this site and ask which to work on
ls
echo "------------------------------"
echo

read -p "Which would you like to migrate from? " -e BACKUP_SET

# go into that back-up set and check if it has a SQL dump
cd $BACKUP_SET
if 
    has_db_export;
then
    clear
    echo

    # the back-up set chosen has a SQL dump
    echo "OK, it looks like we have something to work with. "
    echo
    read -n1 -r -p "Grab the database credentials, and then hit space when you're ready..." KEY

    #hit space to continue
    if 
        [ "$KEY" = '' ];
    then
        get_db_credentials
        echo 
        echo "OK, here's what we got for the database name: "
        echo $DBNAME
    fi
    exit 1

else
    echo "Sorry, it doesn't look like there are any SQL dumps in this back-up set."
    exit 1
fi


# read -p "Those are the back-up sets we have. "
# export_db