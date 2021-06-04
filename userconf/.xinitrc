#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
START_DIR_RC=$HOME/.startdirrc

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f $userresources ] && xrdb -merge $userresources
[ -f $usermodmap ] && xmodmap $usermodmap
[ -f $START_DIR_RC ] && rm $START_DIR_RC

# See synaptics(4) & https://forums.linuxmint.com/viewtopic.php?t=145283
#xinput --list-props 12 | grep -i finger
#xinput --set-prop 12 267 42 48 192
# xinput set-prop 12 275 -112 -112 # natural scrolling
xinput set-prop 12 275 -112 -112
xset s 120 140

# xss-lock -n /usr/bin/slock -- slock

command -V start-pulseaudio-x11 >/dev/null 2>&1 && start-pulseaudio-x11

# start MPD
command -V mpd >/dev/null 2>&1 && mpd

# start btpd
command -V btpd >/dev/null 2>&1 && btpd

ssh-agent awesome
