# bash
## checks if the working directory is clean; i.e. nothing staged, nothing changed

echo "----------"
if [ -z "$(git status --porcelain)" ]; then 
    # Working directory clean excluding untracked files
    echo $(pwd)": "
    echo "Working Directory is CLEAN            ++"
else 
    # Uncommitted changes in tracked files
    echo $(pwd)": "
    echo "we're going through chhannnggessss    --"
fi
echo "----------"