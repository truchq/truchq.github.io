default="/cygdrive/d/github/truchq.github.io.git"
read -p "Enter local branch [$default]: " local
local=${local:-$default}
echo "Local branch is $local"

if [ -z "$local" ]
then
bin/git-merge.sh
else
    printf "Enter remote branch: "
    read remote

    if [ -z "$remote" ]
    then
        printf "Cannot continue without remote branch!\n\n"
        exit
    fi

    git add .
    git add -u
    read -r -p 'Commit description: ' desc

    if [ -z "$desc" ]
    then
        printf "\nExit: commit description is empty!"
    fi

    git commit -m "$desc"
    git checkout $remote
    git status
    git merge $local
    git push
    git status
    git checkout $local
    git status
    printf "\nEnd local commit on $local; merge and push to branch $remote. Well done!\n"
fi