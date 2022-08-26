Synchronize with remote branch "develop" and create a new branch "branch_name" based on that remote branch

```BASH
git checkout develop
git pull
git checkout -b "branch_name"
```

Commit and push changes to remote branch develop
```BASH
git commit # opens editor to type msg
           # vim cmd
           # i = insert to type msg
           # :wq = save and quit 
git add .
git push --set-upstream develop branch_name
```

Modify last N commits (merge commits = pick 1 squash others, edit commits etc...)

```BASH
git rebase -i HEAD~N # N is integer 
                     # modify interactive windows
                     # :wq = save and quit
```
