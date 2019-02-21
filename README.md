# ~~Home directory~~ (or dotfiles, as they call'em)

> If you have an API endpoint with multiple joins, you're screwed anyway and should fix your API.
>
> Linus Torvalds

## Cool utilities

* [bat](https://github.com/sharkdp/bat): a replacement for `cat`

## GNU Stow

I started using stow for easier managing across machines/users. I was a bit
reluctant but this
[awesome website](http://blog.xero.nu/managing_dotfiles_with_gnu_stow) finally
convinced me, instead of copying files everywhere, soft links are created
(so no more `$HOME/.git/`, aww yeah!).
Really easy to use, e.g., to install my awesomewm 4 configuration
files on my `$HOME` (given that this repo is located at `$HOME/<repo>`):

```bash
$ stow awesome4
```

To uninstall:

```bash
$ stow -D awesome4
```

Installing X11 configuration files requires permissions, so:

```bash
$ sudo stow -t / X11
```

## Terminus font

```bash
$ bash install-terminus-font.sh
```

## Awesome

Debug configuration file on a nested Xorg server (depends on Xephyr)

```bash
$ Xephyr :1 -ac -br -noreset -screen 400x400
$ DISPLAY=:1.0 awesome -c /home/jc/.config/awesome/rc.lua
```

## NetworkManager

```bash
$ nmcli device wifi connnect <BSSID> password 'mypassword'
$ echo "Or even better..."
$ nmtui
```

## Notes
To verify password strength, one can use **Pluggable Authentication Modules**
(PAM). Its configuration is implemented using the `pam_cracklib.so`, which
can be replaced by `pam_passwdqc.so` for more options.
[John The Ripper](http://www.openwall.com/john/) is also a good option.

## Audio
Wanna rip an audio CD? No problem, use
[RipRight](http://www.mcternan.me.uk/ripright/); it gets MetaData from
[MusicBrainz](http://musicbrainz.org) (even the album art!).

```bash
$ ripright --require-art -f art.png -o %B/%D/%N - %A - %T --rip-to-all
```

Okay, so let's change the subject. Wanna extract the audio from a video?
We can use `ffmpeg` to accomplish this. Let's first trim the video,
and then extract the audio from the _short_ video.

```bash
$ ffmpeg -i original.mp4 -ss 00:00:05 -t 00:00:07 -async 1 -strict -2 short.mp4
$ ffmpeg -i short.mp4 -vn -acodec copy audio.aac
```
