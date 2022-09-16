Synchronize with remote branch "develop" and create a new branch "branch_name" based on that remote branch

```BASH
git checkout develop
git pull
git checkout -b "branch_name"
```

Commit and push changes to remote branch develop
```BASH
git commit # opens vim editor to type msg
           # i = insert to type msg
           # :wq = save and quit 
git add .
git push --set-upstream develop branch_name
```

Modify last N commits (merge commits = pick 1 squash others, edit commits etc...)

```BASH
git rebase -i HEAD~N # N is integer 
                     # :wq = save and quit
```

Change/troubleshoot SSH key

```BASH
eval `ssh-agent -s` # manually start ssh agent
ssh-add -D # delete all saved keys
ssh-add -l # list all saved keys
ssh-add ~/.ssh/id_XXX # add id_XXX
```
