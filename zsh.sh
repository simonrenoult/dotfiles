export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"

plugins=(git git-debranch docker kubectl zsh-autosuggestions)

alias reload-zsh=". $ZSHRC_ORIGIN"

. $ZSH/oh-my-zsh.sh
