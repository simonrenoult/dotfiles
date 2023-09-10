#!/usr/bin/zsh

export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# -- Path --

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:./node_modules/.bin"

# -- ZSH --

export ZSHRC="$HOME/.zshrc"
export ZSHRC_ORIGIN=$(readlink -f ${ZSHRC})
export ZSHRC_ORIGIN_DIRECTORY=$(dirname "${ZSHRC_ORIGIN}")

# -- Editors --

export EDITOR="vim"
export GUI_EDITOR="subl"

# -- Aliases --

alias grep="grep --color"
alias port="sudo ss -tulpn"
alias k=kubectl
alias vimrc="$EDITOR $HOME/.vimrc"
alias profile="$GUI_EDITOR $ZSHRC_ORIGIN_DIRECTORY"
alias dotfiles=profile
alias cat=bat
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | xsel -ib "
alias reload="source $HOME/.zshrc"
alias r=reload
alias gitrc="$GUI_EDITOR $ZSHRC_ORIGIN_DIRECTORY/git.sh"

# -- Docker --

alias stop_all_containers="docker stop $(docker ps -q)"
alias remove_all_containers="docker rm $(docker ps -a -q)"

# -- QoL --

. /usr/share/autojump/autojump.zsh

function upgrade_all {
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove
    omz update
}

function remove_directories {
	local name="$2"
	local location="$1"
	echo "Removing directories named '"$name"' located in directory '"$location"'..."
	rm -rf $(find "$name" -type d -name "$location")
}

# -- Dependencies --

. $ZSHRC_ORIGIN_DIRECTORY/zsh.sh
. $ZSHRC_ORIGIN_DIRECTORY/notes.sh
. $ZSHRC_ORIGIN_DIRECTORY/git.sh
. $ZSHRC_ORIGIN_DIRECTORY/nvm.sh
