#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f $userresources ] && xrdb -merge $userresources
[ -f $usermodmap ] && xmodmap $usermodmap

xset s 120 140
# xss-lock -n /usr/bin/slock -- slock

command -V start-pulseaudio-x11 >/dev/null 2>&1 && start-pulseaudio-x11

# start MPD
command -V mpd >/dev/null 2>&1 && mpd

# start btpd
command -V btpd >/dev/null 2>&1 && btpd

ssh-agent awesome
