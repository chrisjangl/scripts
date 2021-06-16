# bash
## checks if the working directory is clean; i.e. nothing staged, nothing changed
## @TODO: this doesn't check for any updates from remote repos

echo "----------"
git fetch
if [ -z "$(git status --porcelain)" ]; then 
    # Working directory clean excluding untracked files
    echo $(pwd)": "
    echo "Branch: "$(git branch --show-current)
    echo "Working Directory is CLEAN            ++"
else 
    # Uncommitted changes in tracked files
    echo $(pwd)": "
    echo "we're going through chhannnggessss    --"
fi
echo "----------"