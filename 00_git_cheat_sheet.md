# Git cheat sheet

```bash
# Synchronize with remote branch "develop" and create a new branch "branch_name" based on that remote branch
git checkout develop
git pull
git checkout -b "branch_name"
```

```bash
# Commit and push changes to remote branch develop
git commit # opens vim editor to type msg
           # i = insert to type msg
           # :wq = save and quit 
git add .
git push --set-upstream develop branch_name
```


```bash
# Modify last N commits (merge commits = pick 1 squash others, edit commits etc...)
git rebase -i HEAD~N # N is integer 
                     # :wq = save and quit
```

```bash
# Change/troubleshoot SSH key
eval `ssh-agent -s` # manually start ssh agent
ssh-add -D # delete all saved keys
ssh-add -l # list all saved keys
ssh-add ~/.ssh/id_ed25519 # add id_XXX
```


```bash
# Check branches last 15 branches created following <pattern>
git for-each-ref \
--sort="-committerdate:iso8601" \
--format="%(committerdate:relative)|%(refname:short)|%(committername)" refs/remotes/ \
| grep <pattern> \
| head -15
```


```bash
# most used alias
## https://stackoverflow.com/questions/37410262/how-to-create-a-gitlab-merge-request-via-command-line automatically create the MR for gitlab
alias gpsupm='git push --set-upstream origin $(git branch --show-current) -o merge_request.create'
alias g='git'
alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -a'
alias gbD='git branch -D'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'

alias gc='git commit -v'
alias gcb='git checkout -b'

alias gcd='git checkout develop'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcm='git checkout main'

alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias gu="git reset --soft HEAD~1"

# https://stackoverflow.com/questions/2514172/listing-each-branch-and-its-last-revisions-date-in-git
alias glb='git for-each-ref --sort="-committerdate:iso8601" --format="%(committerdate:relative) | %(refname:short) | %(committername)" refs/heads | head -15'
alias glbr='git for-each-ref --sort="-committerdate:iso8601" --format="%(committerdate:relative) | %(refname:short) | %(committername)" refs/remotes | head -15'
```