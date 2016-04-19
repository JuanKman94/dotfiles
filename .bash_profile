# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/bin:$HOME/.local/bin:/usr/local/heroku/bin:$PATH

export PATH
source ~/.bash_private
