# Preen import test
#########################
######Variables###########
db_pass="a9pKS8yfd!3Q"

###############################
######Function Definitions#####

function decompress_all_tables {
    clear
    echo "We will now decompress all tables."
    echo
    read -n1 -r -p "Hit space when you're ready..." KEY
    #hit space to continue
    if 
        [ "$KEY" = '' ];
    then
        shopt -s nullglob dotglob
        dumps=(*)
        for dump in "${dumps[@]}"; do
            DUMP=${dump}
            echo 
            echo "We're now going to be working on " $DUMP
            echo
            gunzip $DUMP
            echo "If there are no errors above this, we're good."
            echo "________________________________________________"
        done
    fi

}

function import_table {
    echo
    echo "We're going to try to import" $2
    # check if file ends in .sql
    if [ ${2:(-4)} = ".sql" ];
    then
        mysql -p${db_pass} -h127.0.0.1 ${1} < $2
        echo "If there are no errors above this, we're good."
    else
        echo "Nah, it's not a sql file"
    fi
} 

clear
echo "--------------------------"
echo
echo "Press space bar to import database"
echo
echo "--------------------------"
read -n1 -r -p "Hit space when you're ready..." KEY
#hit space to continue
if 
    [ "$KEY" = '' ];
then
    shopt -s nullglob dotglob
    dumps=(*)
    for dump in "${dumps[@]}"; do
        DUMP=${dump}
        echo 
        echo "We're now going to be working on " $DUMP
        echo
        import_table "preenpets" $DUMP
        echo
        echo "-----------------------------------------"
    done
fi