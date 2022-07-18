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

# see synaptics(4)
# see https://forums.linuxmint.com/viewtopic.php?t=145283 (synaptics finger)
#xinput --list-props 12 | grep -i finger
# xinput set-prop 12 267 42 48 192 # synaptics finger: FingerLow, FingerHigh, FingerPress
# xinput set-prop 12 275 -112 -112 # scrolling distance: natural scrolling
#xinput set-prop 12 297 24 42 192 # synaptics finger: FingerLow, FingerHigh, FingerPress
#xinput set-prop 12 305 -112 -112 # scrolling distance: natural scrolling
xset s 120 140

# xss-lock -n /usr/bin/slock -- slock

# per-system stuff, e.g.: `command -V start-pulseaudio-x11 >/dev/null 2>&1 && start-pulseaudio-x11`
[ -f $HOME/.xinit_private ] && sh "$HOME/.xinit_private"

ssh-agent awesome --config $HOME/.config/awesome/rc.lua > "$HOME/.xsession.log"
