local vicious       = require("vicious")
local wibox         = require("wibox")
local xresources    = require("beautiful.xresources")
local xrdb          = xresources.get_current_theme()
local awful         = require("awful")
local format        = string.format
local mpdwidget     = wibox.widget.textbox()
local mpd           = { widget = mpdwidget }

vicious.register(mpdwidget, vicious.widgets.mpd, function (wid, args)
    return string.format("<span color=%q>%s > %s</span>",
            (args["{state}"] == "Playing" and xrdb.foreground or xrdb.color3),
            args["{Artist}"],
            args["{Title}"]
        )
end)

function mpd.stop()
    awful.util.spawn("mpc stop")
end
function mpd.toggle()
    awful.util.spawn("mpc toggle")
end
function mpd.prev()
    awful.util.spawn("mpc prev")
end
function mpd.next()
    awful.util.spawn("mpc next")
end
function mpd.player()
    awful.util.spawn("uxterm -title ncmpcpp -e ncmpcpp")
end

mpd.widget:buttons(awful.util.table.join(
    awful.button({ }, 4, mpd.next ),
    awful.button({ }, 5, mpd.prev ),
    awful.button({ }, 1, mpd.toggle )
))

return mpd
