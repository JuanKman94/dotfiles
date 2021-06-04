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

## Windows

I like [cygwin](https://cygwin.com/) when working on Windows. I made script
to install packages a la aptitute/dnf/whatever, see [cygins](bin/bin/cygins):

```
$ cygins vim
```

Running `ssh-agent` can be tricky. What I do is add this to my `.bash_profile`:

```bash
PATH=$PATH:/usr/share/winpty/bin

alias docker='winpty docker'
alias dc='winpty docker-compose'

# startup of the ssh-agent
SSH_AGENT_RUNNING=$(ps -ef | grep ssh-agent | wc -l)

if [ "$SSH_AGENT_RUNNING" -eq "0" ]; then
  echo "[INFO] Starting SSH Agent"

  eval "$(ssh-agent)" && ssh-add ~/.ssh/id_rsa
  setx SSH_AUTH_SOCK $SSH_AUTH_SOCK
  setx SSH_AGENT_PID $SSH_AGENT_PID

  echo "[INFO] SSH Agent running (PID: $SSH_AGENT_PID)"
fi
```

## PDF handling

* having the [pdftk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/) can't hurt
* GhostScript is probably the most powerful, and verbose, tool available
* here's a [linux journal entry](https://www.linuxjournal.com/content/tech-tip-extract-pages-pdf)

```sh
#!/bin/sh

OUTPUT="merge.pdf"
FILES="$(ls *.pdf | grep -v "$OUTPUT" | sort)"

/usr/local/bin/gs -dBATCH \
    -dNOPAUSE \
    -dSAFER \
    -dFirstPage=1 \
    -dLastPage=1 \
    -q \
    -sDEVICE=pdfwrite \
    -sOutputFile="$OUTPUT" \
    $FILES
```
