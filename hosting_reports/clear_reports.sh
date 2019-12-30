# script to clear the existing reports from reports/
# v1.0

array=( account-notices.txt core.txt updated-plugins.txt skipped-plugins.txt theme.txt )

for i in "${array[@]}"
do
    if [ -f $i ]; then
        rm $i
    fi
done;