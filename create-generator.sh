# variables
REPORTS=reports
GENERATOR="generate-report.sh"
LIVE=~/sites

# copy generator script to each site
cd $LIVE
shopt -s nullglob dotglob
folders=(*/)
for folder in "${folders[@]}"; do
    FOLDER=${folder%/}
    # echo "cp " ~/$GENERATOR $LIVE/$FOLDER/$REPORTS/$GENERATOR
    mkdir -p $LIVE/$FOLDER/$REPORTS
    cp "~/$GENERATOR" "./$FOLDER/$REPORTS/$GENERATOR"
done


