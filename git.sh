#!/usr/bin/zsh

function branch {
    if [ -z "$1" ]; then
        echo "Error: an argument must be provided"
    else
        wip
        git fetch --all > /dev/null
        git checkout -b $1 origin/master
    fi
}

function branches {
    git for-each-ref \
        --sort=committerdate refs/heads/ \
        --format='%(color: cyan)%(committerdate:short) %(color: blue)%(refname:short)'
}


function commit {
    if [ -z "$1" ]; then
        echo "Error: an argument must be provided"
    else
        git commit --allow-empty --message=$1
    fi
}


function current_branch {
    git rev-parse --abbrev-ref HEAD
}


function debranch {
    if [ -z "$1" ]; then
        echo "Error: an argument must be provided"
    else
        local commit_to_extract="$1"
        local branch_name="debranch-${commit_to_extract}"
        branch-from-master $branch_name
        git cherry-pick $commit_to_extract
    fi
}


function melt {
    git add --all
    git commit --amend --no-edit
}


function news {
    git fetch --all > /dev/null
    git --no-pager log --oneline --decorate --first-parent origin/master..HEAD
}


function rebase-on-master {
    git fetch --all > /dev/null
    git rebase origin/master
}


function rebase-on-remote {
    local remote_branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch --all > /dev/null
    git rebase origin/$remote_branch
}


function reset-to-master {
    git fetch --all > /dev/null
    git reset --hard origin/master
}


function reset-to-remote {
    local remote_branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch --all > /dev/null
    git reset --hard origin/$remote_branch
}


function squash-all {
    git fetch --all > /dev/null
    git rebase --interactive --autosquash origin/master
}


function wip {
    git add --all
    git commit --message="wip: undo me with 'git reset --soft HEAD~'"
}


function merged {
    if [ $# -eq 0 ]; then
        git fetch --all > /dev/null
        git log --oneline --decorate --first-parent origin/master
    else
        git fetch --all > /dev/null
        git log --oneline --decorate --first-parent origin/master | grep -i $1
    fi
}


alias gitconfig="$EDITOR $HOME/.gitconfig"
alias gitrc=gitconfig
alias gitignore="$EDITOR $HOME/.gitignore"

alias push='git push --force origin $(git rev-parse --abbrev-ref HEAD)'
alias tags='git tag --list -n1'
alias undo='git reset --soft HEAD~'
alias nuke='git reset --hard && git clean --force -d'
alias fixup='git add --all && git commit --fixup'
alias master='git checkout master'
alias co='git checkout'

alias m=master
alias b=branch
alias cm=commit
alias cb=current_branch
alias db=debranch
alias n=news
alias rom=rebase-on-master
alias rtm=reset-to-master
alias rtr=reset-to-remote
alias ror=rebase-on-remote
alias sa=squash-all
alias w=wip
