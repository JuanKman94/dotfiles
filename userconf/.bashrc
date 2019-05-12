# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# add a trailing slash when autocompleting a symlink
bind 'set mark-symlinked-directories on'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
stty erase '^?'

case "$TERM" in
  st-*)
    # st reads .bashrc instead of .bash_profile
    source .bash_profile
    ;;
  *)
    ;;
esac
