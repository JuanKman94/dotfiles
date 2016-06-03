# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Remove legacy behaviour
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# User specific environment and startup programs

PATH=$HOME/bin:$HOME/.local/bin:/usr/local/heroku/bin:$PATH

export PATH
source ~/.bash_private
alias gl='git log --graph'
alias gs='git status'
alias ga='git add'
alias gc='git checkout'
