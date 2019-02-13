# Social Digital (GoDaddy) - STAGING version
# Version 1.0.0

# our variables
SERVER="public_html/staging"
BU_FOLDER="dc_bu"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H%M)

# function definitions

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

function move_wp_content {
	# check if there's already an "old directory", and mkdir if there isn't
	if [ ! -d "old" ]; then
		mkdir old/
	fi;

	# cd to the wp-content folder
	cd ~/$SERVER/$WPCONTENT

	# for each folder in wp-content, move it to dc_bu/old/ (unless that folder IS dc_bu)
	for i in $(ls -d */); do
		# if it's the folder with old instances of the site, continue
		if [[ $i == dc_bu* ]]; then
			continue
		fi;
		echo "Moving " ${i%} " to dc_bu/old/ .......";
		mv ${i%} dc_bu/old/${i%}
		echo "done!"
		echo
		echo "-----"
		echo
	done

	# cd back to BU_FOLDER
	cd dc_bu/

}

#### TO DO: move old content to another directory first ####
function restore_site {
	clear
	echo 
	echo "-------------------------"
	echo
	echo $SITEFOLDER
	echo
	echo "-------------------------"
	
	# check that we have any backups to restore
	if [ ! -d "$BU_FOLDER" ]; then
		echo Sorry, it doesn\'t look like we have anything to restore...
	fi

	cd $BU_FOLDER

	# list the backups we have available
	for i in $(ls -d */); do
		# if it's the folder with old instances of the site, continue
		if [[ $i == old* ]]; then
			continue
		fi;
		echo ${i%};
	done

	# and ask the user which to restore from
	read -p "These are the available backups. Which would you like to restore? " -e BACKUPTORESTORE

	if [[ $BACKUPTORESTORE == Old* ]]; then
		echo "No such file or directory, try again"
	fi

	move_wp_content

	cd $BACKUPTORESTORE

	shopt -s nullglob dotglob
	archives=(*.zip)
	for ARCHIVE in "${archives[@]}"; do
		echo Working on restoring ${ARCHIVE} to ${WPCONTENT}...
		unzip -d ~/$SERVER/$WPCONTENT ~/$SERVER/$WPCONTENT/$BU_FOLDER/$BACKUPTORESTORE/$ARCHIVE
		echo ...done!
	done

	shopt -s nullglob
	if [ -n "$(echo *.sql)" ];
	then 
		echo Looks like we have a sql dump, will start the import via WP-CLI
		wp db import *.sql
		echo looks OK....
	else
		echo looks like we DONT have a sql dump
	fi
}

# function restore_db {

# }
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