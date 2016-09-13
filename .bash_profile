# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Remove legacy behaviour
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# User specific environment and startup programs

EDITOR=vi
PATH=$HOME/bin:$HOME/.config/composer/vendor/bin:$HOME/.local/bin:$PATH
PATH=$PATH:./node_modules/.bin # node packages

export EDITOR
export PATH
source ~/.bash_private
alias gl='git log --graph'
alias gs='git status'
alias ga='git add'
alias gc='git checkout'
alias gd='git diff'

# ls
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
