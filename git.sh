#!/usr/bin/zsh

alias gitconfig="$EDITOR $HOME/.gitconfig"
alias gitrc=gitconfig
alias gitignore="$EDITOR $HOME/.gitignore"

alias branch='git checkout -b'
alias commit='git commit --allow-empty --message'
alias push='git push --force origin $(git rev-parse --abbrev-ref HEAD)'
alias tags='git tag --list -n1'
alias undo='git reset --soft HEAD~'
alias nuke='git reset --hard && git clean --force -d'
alias fixup='git add --all && git commit --fixup'

function branch-from-master {
    if [ -z "$1" ]; then
        echo "Error: an argument must be provided"
    else
        wip
        git checkout master
        git checkout -b $1
    fi
}

function melt {
    git add --all
    git commit --amend --no-edit
}

function merged {
    if [ $# -eq 0 ]; then
        git fetch origin > /dev/null
        git log --oneline --decorate --first-parent origin/master
    else
        git fetch origin > /dev/null
        git log --oneline --decorate --first-parent origin/master | grep -i $1
    fi
}

function news {
    git fetch origin > /dev/null
    git log --oneline --decorate --first-parent origin/master..HEAD
}

function rebase-on-master {
    git fetch origin
    git rebase origin/master
}

function reset-to-master {
    git fetch --all
    git reset --hard origin/master
}

function squash {
    git fetch origin
    git rebase --interactive --autosquash origin/master
}

function wip {
    git add --all
    git commit --message="wip: undo me with 'git reset --soft HEAD~'"
}

