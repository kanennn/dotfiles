# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
setopt globdots
unsetopt autocd beep extendedglob
bindkey -v

autoload -Uz zmv
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
# zstyle :compinstall filename '$HOME/.zshrc' #this needs fixing???

# autoload -Uz compinit
# compinit
#
# End of lines added by compinstall
alias kssh="kitty +kitten ssh"
