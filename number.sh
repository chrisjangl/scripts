BU_FOLDER="dc_bu"
MAMP_FOLDER="/mnt/c/MAMP/htdocs"

function get_num_backups {
    FULL_PATH=$MAMP_FOLDER/wp-content/$BU_FOLDER
    NUM_BACKUPS=$(find $FULL_PATH -maxdepth 1 -name "201*" | wc -l)
}