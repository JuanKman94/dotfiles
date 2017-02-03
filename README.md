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

## NMCLI
$ nmcli device wifi connnect <BSSID> password 'mypassword'

## Notes
To verify password strenght, one can use **Pluggable Authentication Modules**
(PAM). Its configuration is implemented using the `pam_cracklib.so`, which
can be replaced by `pam_passwdqc.so` for more options.
[John The Ripper](http://www.openwall.com/john/) is also a good option.

### Audio
Wanna rip an audio CD? No problem, use [RipRight](http://www.mcternan.me.uk/ripright/);
it gets MetaData from [MusicBrainz](http://musicbrainz.org), even the album art!

```bash
$ ripright --require-art -f art.png -o %B/%D/%N - %A - %T --rip-to-all
```

Okay, so let's change the subject. Wanna extract the audio from a video? We can use `ffmpeg`
to accomplish this. Let's first trim the video, and then extract the audio from the _short_
video.

```bash
$ ffmpeg -i original.mp4 -ss 00:00:05 -t 00:00:07 -async 1 -strict -2 short.mp4
$ ffmpeg -i short.mp4 -vn -acodec copy audio.aac
```
