# bash
## checks if the working directory is clean; i.e. nothing staged, nothing changed

if [ -z "$(git status --porcelain)" ]; then 
  # Working directory clean excluding untracked files
  echo "Working Directory is CLEAN"
else 
  # Uncommitted changes in tracked files
  echo "nah, we're going through chhaaannnggeessss"
fi