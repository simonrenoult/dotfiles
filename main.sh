#!/usr/bin/zsh

export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:./node_modules/.bin"

export EDITOR="vim"
export GUI_EDITOR="subl"

. /usr/share/autojump/autojump.zsh

alias grep="grep --color"
alias port="sudo ss -tulpn"

alias vimrc="$EDITOR $HOME/.vimrc"

alias dotfiles="subl $HOME/code/dotfiles"
alias profile=dotfiles

function upgrade {
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove
    upgrade_oh_my_zsh
}

. $HOME/code/dotfiles/zsh.sh
. $HOME/code/dotfiles/notes.sh
. $HOME/code/dotfiles/git.sh
. $HOME/code/dotfiles/nvm.sh
