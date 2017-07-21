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
   { "Chromium", "chromium" },
   { "VLC", "vlc" },
   { "Arduino", "arduino" },
   { "Shutdown", { { "No ", "" }, { "Suspend", "systemctl suspend -i" }, { "Reboot", "sudo shutdown -r now" }, { "Yes", "sudo shutdown -h now" } } }
}

return supermenu
