#!/usr/bin/zsh

export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:./node_modules/.bin"

export ZSHRC="$HOME/.zshrc"
export ZSHRC_ORIGIN=$(readlink -f ${ZSHRC})
export ZSHRC_ORIGIN_DIRECTORY=$(dirname "${ZSHRC_ORIGIN}")

export EDITOR="vim"
export GUI_EDITOR="subl"

. /usr/share/autojump/autojump.zsh

alias grep="grep --color"
alias port="sudo ss -tulpn"

alias k=kubectl

alias vimrc="$EDITOR $HOME/.vimrc"

alias profile="$GUI_EDITOR $ZSHRC_ORIGIN_DIRECTORY"
alias dotfiles=profile

alias stopAllContainers="docker stop $(docker ps -q)"
alias removeAllContainers="docker rm $(docker ps -a -q)"
alias cat=bat

alias uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | xsel -ib "

function upgrade {
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove
    omz update
}

function us {
    firefox https://mobilize-pay.atlassian.net/browse/AC-$1
}

. $ZSHRC_ORIGIN_DIRECTORY/zsh.sh
. $ZSHRC_ORIGIN_DIRECTORY/notes.sh
. $ZSHRC_ORIGIN_DIRECTORY/git.sh
. $ZSHRC_ORIGIN_DIRECTORY/nvm.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/simon/bin/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/simon/bin/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/simon/bin/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/simon/bin/gcloud/google-cloud-sdk/completion.zsh.inc'; fi
