# Preen Pets (SiteGround) - Staging version
# version 1.0.1

# our variables
STAGING=~/staging/
LIVE=~/public_html/clients
# SERVER="public_html/clients"
SERVER="staging"
BU_FOLDER="dc_bu"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)
TIMESTAMP=${DATE}_${TIME}

# function definitions
function makebackup {
	# check if BU folder exists, mkdir it if it doesn't
	if [ ! -d "$BU_FOLDER" ]; then
		mkdir "$BU_FOLDER"
	fi

	if [ ! -d "$BU_FOLDER/$DATE" ]; then
		mkdir $BU_FOLDER/$DATE
	fi

	# check if this folder was backed up today
	if [ true ]; then
		zip -r $BU_FOLDER/$DATE/$1_$TIMESTAMP.zip $1/
	fi
}

function export_db {
	clear

    echo "Remember, we're currently working with: "
    echo
    echo
    echo "-----------------------------------------------------------"
    echo "${SITEFOLDER}"
    echo "-----------------------------------------------------------"
    echo
    echo
    echo

	#Get the credentials for the database BU
	read -p "What is the database name? " -e DBNAME
	read -p "Thanks. What is the username to access $DBNAME? " -e DBUSER
	#read -p "Cool. And lastly, what is the password for $DBUSER? " -e DBPASS
	echo "OK, about to export $DBNAME ....."

	# check if BU folder exists, mkdir it if it doesn't
	if [ ! -d "$BU_FOLDER" ]; then
		mkdir "$BU_FOLDER"
	fi

	if [ ! -d "$BU_FOLDER/$DATE" ]; then
		mkdir $BU_FOLDER/$DATE
	fi

	mysqldump -u ${DBUSER} -p ${DBNAME} > ${BU_FOLDER}/${DATE}/${DBNAME}_${TIMESTAMP}.sql
	echo
	echo "OK, database should have been successfully exported."
	echo
}

# TO DO - FIX THIS FUNCTION TO FIT OUR NEW BACKUP SYSTEM (currently set to check for Updraft backups)
function hasbackups {

	local result=false

	FULL_PATH=./$1$UPDRAFT_FOLDER
	#check if the site has an Updraft folder
	if [ -d $FULL_PATH ]; then
		#if it does, find out how many files are named "backup_*"
		NUM_BACKUPS=$(find $FULL_PATH -maxdepth 1 -name "backup*" | wc -l)
		if [ $NUM_BACKUPS -gt 0 ]; then
			echo "Site $1 has $NUM_BACKUPS backups"
			local result=true
		fi
	fi
	#echo "$result"
}

function backup_site {
	shopt -s nullglob dotglob
	folders=(*/)
	for folder in "${folders[@]}"; do
		FOLDER=${folder%/}
		if [ $FOLDER = "dc_bu" ]; 
		then
			continue
		else
			if [ $FOLDER = "updraft" ];
			then
				continue
			fi;
		fi;
		echo backing up $FOLDER '...'
		makebackup "$FOLDER"
		echo done!
	done

}

function cp_to_staging {
	clear
	echo
	# check if there is a folder in staging/ with the same name as our working folder
	if [ -d $STAGING/$SITEFOLDER ]
	then
		echo "It looks like there is a matching staging folder for this site."
		echo
		echo "We'll be copying these back-up sets to the staging folder now..."
		# check if there's a back-up folder
		if [ ! -d $STAGING/$SITEFOLDER/wp-content/$BU_FOLDER ];
		then
			# if there isn't, mkdir one.
			mkdir $STAGING/$SITEFOLDER/wp-content/$BU_FOLDER
		fi
		# check if we already have a back-up set for today
		if [ ! -d $STAGING/$SITEFOLDER/wp-content/$BU_FOLDER/$DATE ];
		then
			# if we don't, let's make one
			mkdir $STAGING/$SITEFOLDER/wp-content/$BU_FOLDER/$DATE
		fi
		# now that we definitely have a back-up set for today, copy the backups to it
		cp $LIVE/$SITEFOLDER/wp-content/$BU_FOLDER/$DATE/*$TIMESTAMP* $STAGING/$SITEFOLDER/wp-content/$BU_FOLDER/$DATE/

		# do a cursory check that the staging back-up set has at least one backup in it
		NUM_BACKUPS=$(find $STAGING/$SITEFOLDER/wp-content/$BU_FOLDER/$DATE/ -maxdepth 1 -name "*$TIMESTAMP*" | wc -l)
		if [ $NUM_BACKUPS -gt 0 ]; then
			echo "It appears that the copy was successful."
		fi
	else
		echo
		echo "It doesn't look like we have a matching folder in the staging area. Please manually copy the backups."
	fi

}


# let's get started
clear

echo "We'll be backing up some sites here. Let's get started. "
echo

echo "Here is a list of the directories we have availabe to work with: "
echo
echo "-----------------------------------------------------------"

# list the directories available and ask which to work on
cd $SERVER
ls
echo "-----------------------------------------------------------"

echo
read -p "REMINDER: We are about to work on $SERVER - which directory are we backing up right now? " -e SITEFOLDER

# cd to that folder
cd $SITEFOLDER
cd wp-content
backup_site
export_db
echo 
echo 
echo "______________________________________________________"
echo "Looks like we're done here. "
echo

# check if the user wants to copy the newly created backups to the staging site for this site
echo "Would you like to copy these backups to the staging site for $SITEFOLDER ? "
read -n1 -r -p "Press y for Yes, n for No " KEY

# check their response
if 
	[ "$KEY" = 'y' ];
then
	cp_to_staging
else
	if [ "$KEY" = 'n' ];
	then
		echo 
		echo "Ok, thanks for playing."
		exit
	fi
fi