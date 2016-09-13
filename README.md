# Home directory files (or dotFiles, as they call'em)

## Fonts

Add the `--fonts` parameter to the setup script to run the `install-*-font.sh` during installation
```bash
$ bash setup.sh --fonts
```

## Awesome

Debug configuration file on a nested Xorg server (depends on Xephyr)
```bash
$ Xephyr :1 -ac -br -noreset -screen 400x400
$ DISPLAY=:1.0 awesome -c /home/jc/.config/awesome/rc.lua
```

## Quotes

> If you have an API endpoint with multiple joins, you're screwed anyway and should fix your API.
Linus Torvalds
