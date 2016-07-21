# Home directory files (or dotFiles, as they call'em)

## Awesome

Debug configuration file on a nested Xorg server (depends on Xephyr)
```bash
$ Xephyr :1 -ac -br -noreset -screen 400x400
$ DISPLAY=:1.0 awesome -c /home/jc/.config/awesome/rc.lua
```
