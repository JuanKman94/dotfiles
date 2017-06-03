-- {{{ Menu entries for this host

module("debian.menu")

Personal_menu = {}

Personal_menu['Personal_GUI'] = {
   { "Firefox", "apulse firefox-esr" },
   { "Thunderbird", "thunderbird" },
}

Personal_menu['Personal_CLI'] = {
   { "cmus", "x-terminal-emulator -e cmus" },
}

Personal_menu['Personal_System'] = {
   { "Shutdown", { { "No", "" }, { "Reboot", "sudo reboot" }, { "Yes", "sudo shutdown -h now" } } }
}

Personal_menu["Personal"] = {
    { "GUI", Personal_menu['Personal_GUI'] },
    { "CLI", Personal_menu['Personal_CLI'] },
    { "System", Personal_menu['Personal_System'] },
}
