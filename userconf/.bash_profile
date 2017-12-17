# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f $HOME/.bash_private ]; then
    source $HOME/.bash_private
fi

# Remove legacy behaviour
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# User specific environment and startup programs

EDITOR=vim

PATH=$PATH:$HOME/bin:$HOME/.local/bin
#PATH=$PATH:$HOME/.config/composer/vendor/bin:./vendor/bin # composer packages
#PATH=$PATH:$HOME/.npm-global/bin:./node_modules/.bin # node packages
GOPATH=$HOME/.go

####### Bash prompt #######

RESET="\[$(tput sgr0)\]"
RED="\[$(tput setaf 1)\]"
#GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
#BLUE="\[$(tput setaf 4)\]"
#MAGENTA="\[$(tput setaf 5)\]"
#CYAN="\[$(tput setaf 6)\]"
#WHITE="\[$(tput setaf 7)\]"

PS1="\u@${RED}\H${RESET} ${YELLOW}\W${RESET}> "

# Git 
alias gl='git log --graph'
alias gs='git status'
alias ga='git add'
alias gc='git checkout'
alias gd='git diff'
alias gcm='git commit -m'
alias gll='git pull'
alias gsh='git push'

alias vim='vim -p'
#alias python=/usr/bin/python3

####### Exports #######

export EDITOR
export PATH
export GOPATH
export PS1

# ls
export LS_OPTIONS='--color=auto -hF'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'

export LESS="$LESS -R"
