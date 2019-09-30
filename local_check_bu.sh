BU_FOLDER="dc_bu"
MAMP_FOLDER="/mnt/c/MAMP/htdocs"

function get_num_backups {
    # FULL_PATH=$MAMP_FOLDER/wp-content/$BU_FOLDER
    NUM_BACKUPS=$(find . -maxdepth 1 -name "201*" | wc -l)
    echo NUM_BACKUPS
}

cd MAMP_FOLDER
for direc in $(ls);
do
    cd $MAMP_FOLDER/$direc/wp-content/
    echo "$direc has "
    get_num_backups
    # echo $direc size is $(du -sh ./$direc);
done;



