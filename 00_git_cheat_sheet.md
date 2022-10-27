# Git cheat sheet

Synchronize with remote branch "develop" and create a new branch "branch_name" based on that remote branch

```bash
git checkout develop
git pull
git checkout -b "branch_name"
```

Commit and push changes to remote branch develop

```bash
git commit # opens vim editor to type msg
           # i = insert to type msg
           # :wq = save and quit 
git add .
git push --set-upstream develop branch_name
```

Modify last N commits (merge commits = pick 1 squash others, edit commits etc...)

```bash
git rebase -i HEAD~N # N is integer 
                     # :wq = save and quit
```

Change/troubleshoot SSH key

```bash
eval `ssh-agent -s` # manually start ssh agent
ssh-add -D # delete all saved keys
ssh-add -l # list all saved keys
ssh-add ~/.ssh/id_ed25519 # add id_XXX
```

Check branches last 15 branches created following <pattern>

```bash
git for-each-ref \
--sort="-committerdate:iso8601" \
--format="%(committerdate:relative)|%(refname:short)|%(committername)" refs/remotes/ \
| grep <pattern> \
| head -15
```
