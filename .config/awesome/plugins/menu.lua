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
   { "Vifm", terminal .. " -e vifm" },
   { "Google Chrome", "google-chrome-stable" },
   { "Telegram", "telegram" },
   { "VirtualBox", "virtualbox" },
   { "VLC", "vlc" },
   { "Arduino", "arduino" },
   { "Shutdown", { { "No ", "" }, { "Reboot", "reboot" }, { "Yes", "shutdown -h now" } } }
}
