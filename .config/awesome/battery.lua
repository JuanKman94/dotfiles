local awful = require("awful")
local vicious = require("vicious")

battery = awful.widget.progressbar()
battery:set_width(8)
battery:set_height(10)
battery:set_vertical(true)
battery:set_background_color("#494B4F")
battery:set_border_color(nil)
battery:set_color( {
  type = "linear",
  from = { 0, 0 },
  to = { 0, 10 },
  stops = {
    { 0, "AECF96" },
    { 0.5, "#88A175" },
    { 1, "#FF5656" }
  }
} )
vicious.register(battery, vicious.widgets.bat, "$2", 61, "BAT0")
