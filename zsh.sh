export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"
DISABLE_AUTO_UPDATE="true" 

plugins=(git docker zsh-autosuggestions)

alias reload-zsh=". $ZSHRC_ORIGIN"

. $ZSH/oh-my-zsh.sh
