#!/usr/bin/zsh

function list-files {
    git diff --name-only main..HEAD
}

function create-branch {
    if [ -z "$1" ]; then
        echo "Error: an argument must be provided"
    else
        wip
        git fetch --all --prune > /dev/null
        git switch --create $1 origin/main
    fi
}

function branches {
    git for-each-ref \
        --sort='authordate:iso8601' \
        --format='%(color:cyan)%(authordate:relative) %(color:blue)%(refname:short)' \
        refs/heads
}

function current-branch {
    git rev-parse --abbrev-ref HEAD
}

function debranch {
    if [ -z "$1" ]; then
        echo "Error: an argument must be provided"
    else
        local commit_to_extract="$1"
        local branch_name="debranch-${commit_to_extract}"
        branch-from-main $branch_name
        git cherry-pick $commit_to_extract
    fi
}

function melt {
    git add --all
    git commit --amend --no-edit
}

function news {
    git fetch --all --prune > /dev/null
    git --no-pager log --oneline --decorate --first-parent origin/main..HEAD
}

function rebase-on-main {
    git fetch --all --prune > /dev/null
    git rebase origin/main
}

function rebase-on-remote {
    local remote_branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch --all --prune > /dev/null
    git rebase origin/$remote_branch
}

function reset-to-main {
    git fetch --all --prune > /dev/null
    git reset --hard origin/main
}

function reset-to-remote {
    local remote_branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch --all --prune > /dev/null
    git reset --hard origin/$remote_branch
}

function squash-all {
    GIT_EDITOR=true git rebase --interactive --autosquash main
}

function wip {
    git add --all
    git commit --message="wip: undo me with 'git reset --soft HEAD~'"
}

function merged {
    if [ $# -eq 0 ]; then
        git fetch --all --prune > /dev/null
        git log --oneline --decorate --first-parent origin/main
    else
        git fetch --all --prune > /dev/null
        git log --oneline --decorate --first-parent origin/main | grep -i $1
    fi
}

alias gitconfig="$EDITOR $HOME/.gitconfig"
alias gitrc=gitconfig
alias gitignore="$EDITOR $HOME/.gitignore"

alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias putsch='git push --force origin $(git rev-parse --abbrev-ref HEAD)'
alias tags='git tag --list -n1'
alias undo='git reset --soft HEAD~'
alias nuke='git reset --hard && git clean --force -d'
alias fixup='git commit --fixup'
alias fixup-all='git add --all && git commit --fixup'
alias master='git checkout master'
alias main='git checkout main'
alias co='git checkout'
alias clean='git prune && git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'

alias m=main
alias rom=rebase-on-main
alias rtm=reset-to-main
alias rtr=reset-to-remote
