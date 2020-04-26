#!/usr/bin/zsh

export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:./node_modules/.bin"

export DOTFILES="$HOME/projects/dotfiles"

export EDITOR="vim"
export GUI_EDITOR="subl"

. /usr/share/autojump/autojump.zsh

alias grep="grep --color"
alias port="sudo ss -tulpn"

alias vimrc="$EDITOR $HOME/.vimrc"

alias profile="$GUI_EDITOR $DOTFILES"
alias dotfiles=profile

function upgrade {
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove
    upgrade_oh_my_zsh
}

. $DOTFILES/zsh.sh
. $DOTFILES/notes.sh
. $DOTFILES/git.sh
. $DOTFILES/nvm.sh
