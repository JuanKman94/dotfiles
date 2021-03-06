# .bash_profile

# Get the aliases and functions
case "$TERM" in
  st-*)
    # st reads .bashrc instead of .bash_profile
    ;;
  *)
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
    ;;
esac

if [ -f $HOME/.bash_private ]; then
    source $HOME/.bash_private
fi

# Remove legacy behaviour
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# User specific environment and startup programs

EDITOR=vim

PATH=$PATH:$HOME/bin:$HOME/.local/bin:/snap/bin
#PATH=$PATH:$HOME/.config/composer/vendor/bin:./vendor/bin # composer packages
#PATH=$PATH:$HOME/.npm-global/bin:./node_modules/.bin # node packages
GOPATH=$HOME/.go

####### sh prompt #######

RESET='\[\e[0m\]'
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
MAGENTA='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
WHITE='\[\033[0;37m\]' # actually light gray but whatever
#LIGHT_RED='\[\033[1;31m\]'
# etc.

PS1="\u${RED}@${RESET}${MAGENTA}\H ${YELLOW}\W${RESET}> "

# Git
alias g='git log --oneline -n 30'
alias gl='git log --graph'
alias gs='git status'
alias ga='git add'
alias gb='git --no-pager branch -a'
alias gc='git checkout'
alias gcm='git commit -m'
alias gcmm='git commit --no-ff -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gll='git pull'
alias gsh='git push'
alias gsha='git push --all'
alias gshf='git push --force-with-lease'

alias vim='vim -p'
#alias python=/usr/bin/python3

####### Exports #######

export EDITOR
export PATH
export GOPATH
export PS1
export MAKEFLAGS=-j$(nproc)

# ls
export LS_OPTIONS='--color=auto -hF'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls -l'
alias la='ls -A'

export LESS="$LESS -R"

# colors
local256="$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION"

if [ -n "$local256" ] || [ -n "$SEND_256_COLORS_TO_REMOTE" ]; then

  case "$TERM" in
    'xterm') TERM=xterm-256color;;
    'screen') TERM=screen-256color;;
    'Eterm') TERM=Eterm-256color;;
  esac
  export TERM

  if [ -n "$TERMCAP" ] && [ "$TERM" = "screen-256color" ]; then
    TERMCAP=$(echo "$TERMCAP" | sed -e 's/Co#8/Co#256/g')
    export TERMCAP
  fi
fi

unset local256

echo -e "\tMan is just an animal"
echo -e "\t\ttrying to figure out"
echo -e "\t\t\thow to kill time through his days..."
echo "  -- Kanji, Persona 4"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
