# Fedora Installation

Install basic dependencies, especially important the RPMFusion repositories
and the drivers (Thinkpad X220 specific):

```bash
# dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
> https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# dnf install -q -y vim ansible NetworkManager-tui dnf install iwl600g2?-firmware
```

If the wifi drivers do not work by installing them with DNF, download them
from the
[official repository](https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git)
and place them in `/usr/local/lib/firmware`

Install wm:

```bash
# cd ansible/ansible
# ansible-playbook awesome
```

Configure graphical environment

```bash
# dnf install -q -y slim
# systemctl set-default graphical
```

Install MPD, client and configure it:

```bash
$ echo 'TODO'
```
