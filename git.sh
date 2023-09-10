#!/bin/zsh

PROJECT_PREFIX="<todo>"
MAIN_BRANCH=master

## -- Commits --


function most_recent_commit_message {
    git --no-pager log -1 --pretty=%s
}

function show_last_10_commits {
    git --no-pager log --oneline --decorate -10
}

function commit {
    git add --all
    git commit --message="$(current_branch) $1"
}

function wip {
    local wip_message="wip: undo with git reset --soft HEAD~"
    
    git add --all
    git commit --message=$wip_message
}

function melt {
    git add --all
    git commit --amend --all --no-edit    
}

function undo {
    local commit_message=$(most_recent_commit_message)

    echo "Undoing commit: $commit_message"
    git reset --soft HEAD~
}

function fixup {
    local commit=$1

    git add --all
    git commit --fixup=$commit
    git -c sequence.editor=: rebase --interactive "$commit"^ --autosquash
}
compdef _git fixup_all=git-commit


## -- Branches --


function current_branch {
    git rev-parse --abbrev-ref HEAD
}

function list_most_recent_branches {
    git for-each-ref \
        --sort=committerdate refs/heads/ \
        --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
}

function switch_branch {
    local target_branch=$1

    if [[ $target_branch == "$PROJECT_PREFIX"* ]]
    then
        git switch $target_branch
    else
        git switch $PROJECT_PREFIX-$target_branch
    fi
}

function create_branch {
    local branch_name=$1
    local start_point=$2
    
    if [[ -z "$start_point" ]]
    then
        git switch --create $PROJECT_PREFIX-$branch_name
    else
        git switch --create $PROJECT_PREFIX-$branch_name $start_point
    fi
}

function backup_branch {
    local branch_to_backup=$(current_branch)
    local suffix="-backup"

    git switch --create $branch_to_backup$suffix $branch_to_backup
    git switch - 
}


## -- Push --


function push {
    git push origin $(current_branch)
}


function push_no_ci {
    git push origin $(current_branch) -o ci.skip
}


function putsch {
    git push --force-with-lease origin $(current_branch)
}


function putsch_no_ci {
    git push --force-with-lease origin $(current_branch) -o ci.skip
}


## -- Rebase & Reset --


function rebase_on_master {
    git fetch --all --prune > /dev/null
    git rebase origin/$MAIN_BRANCH
}

function rebase_on_remote {
    local remote_branch=$(current_branch)
    git fetch --all --prune > /dev/null
    git rebase origin/$remote_branch
}

function reset_to_master {
    git fetch --all --prune > /dev/null
    git reset --hard origin/MAIN_BRANCH
}

function reset_to_remote {
    local remote_branch=$(current_branch)
    git fetch --all --prune > /dev/null
    git reset --hard origin/$remote_branch
}

function nuke {
    go_to_root
    git reset --hard
    git clean --force -d    
}


## -- Misc --


function go_to_root {
    cd $(git rev-parse --show-toplevel)
}

function master {
    git switch $MAIN_BRANCH    
}


## -- Aliases --


alias root=go_to_root

### One-letter aliases, should never be destructive

alias m=master
alias b=list_most_recent_branches

### Multiple-letters aliases

alias co=commit
alias st='git status'
alias br=list_most_recent_branches
alias bb=backup_branch
alias cb=create_branch
alias sw=switch_branch
alias lo=show_last_10_commits
alias rom=rebase_on_master
alias ror=rebase_on_remote
alias rtm=reset_to_master
alias rtr=reset_to_remote
