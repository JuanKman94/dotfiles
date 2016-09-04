-- {{{ Menu
-- Create a laucher widget and a main menu
--[[
myawesomemenu = {
   { "manual", "xterm -e man awesome" },
   { "edit config", "vim " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

return { { "awesome", myawesomemenu, beautiful.awesome_icon },
         { "open terminal", terminal },
         { "supermenu", supermenu, beautiful.awesome_icon}
       }
--]]

supermenu = {
   { "Firefox", "firefox-de", "/usr/share/firefox-developer/browser/chrome/icons/default/default16.png"},
   { "Pragha", "pragha", "/usr/share/rhythmbox/plugins/context/img/Discogs16x16.png" },
   { "Transmission", "transmission-gtk" },
   { "Thunar", "thunar" },
   { "Google Chrome", "google-chrome-stable" },
   { "Telegram", "telegram" },
   { "VirtualBox", "virtualbox" },
   { "VLC", "vlc" },
   { "Nautilus", "nautilus" },
   { "Gnome Control Center", "gnome-control-center" },
   { "Shutdown", { { "No ", "" }, { "Reboot", "reboot" }, { "Si", "shutdown -h now" } } }
}
