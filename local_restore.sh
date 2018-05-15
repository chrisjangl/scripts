# Localhost version
# Version 0.9.1

# our variables
#SERVER="public_html/staging"
SERVER="/mnt/c/MAMP/htdocs"
BU_FOLDER="dc_bu"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)

# function definitions
function makebackup {
	TIMESTAMP=${DATE}_${TIME}
	# check if BU folder exists, mkdir it if it doesn't
	if [ ! -d "$BU_FOLDER" ]; then
		mkdir "$BU_FOLDER"
	fi

	if [ ! -d "$BU_FOLDER/$DATE" ]; then
		mkdir $BU_FOLDER/$DATE
	fi

	# TO DO - CHANGE THIS TO A CONDITIONAL
	# check if this folder was backed up today
	if [ true ]; then
		zip -r $BU_FOLDER/$DATE/$1_$TIMESTAMP.zip $1/
	fi
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
		if [ $FOLDER = "dc_bu" ]; then
			continue
		fi;
		echo backing up $FOLDER '...'
		makebackup "$FOLDER"
		echo done!
	done
}

#### TO DO: move old content to another directory first ####
function restore_site {
	
	# check that we have any backups to restore
	if [ ! -d "$BU_FOLDER" ]; then
		echo Sorry, it doesn\'t look like we have anything to restore...
	fi

	cd $BU_FOLDER

	# list the backups we have available
	for i in $(ls -d */); do
		# if it's the folder with old instances of the site, continue
		if [[ $i == Old* ]]; then
			continue
		fi;
		echo ${i%};
	done

	# and ask the user which to restore from
	read -p "These are the available backups. Which would you like to restore? " -e BACKUPTORESTORE

	if [[ $BACKUPTORESTORE == Old* ]]; then
		echo "No such file or directory, try again"
	fi

	cd $BACKUPTORESTORE

	shopt -s nullglob dotglob
	archives=(*.zip)
	for ARCHIVE in "${archives[@]}"; do
		echo Working on restoring ${ARCHIVE} to ${WPCONTENT}...
		unzip -d $SERVER/$WPCONTENT $SERVER/$WPCONTENT/$BU_FOLDER/$BACKUPTORESTORE/$ARCHIVE
		echo ...done!
	done
}
#################################################
#################################################
############### let's get started ###############
#################################################
clear
# list the directories available and ask which to work on
cd $SERVER
echo
ls
echo 
echo "-----------------------------------------------"
echo
read -p "REMINDER: We are about to work on $SERVER - which site are we going to restore to? " -e SITEFOLDER

# Create out variable for $wp-content
WPCONTENT=$SITEFOLDER/wp-content
cd $WPCONTENT
restore_site