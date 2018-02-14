local vicious   = require("vicious")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local mybat     = wibox.widget.progressbar()
local img       = wibox.widget.imagebox(
                    "/usr/share/icons/Adwaita/scalable/devices/battery-symbolic.svg",
                    true)
local batwidget = wibox.widget {
    {
        img,
        forced_width = 16,
        left = 0, right = 4, top = 4, bottom = 0,
        layout = wibox.container.margin
    },
    {
        {
            max_value     = 1,
            widget        = mybat,
            border_width  = 0.4,
            border_color  = beautiful.fg_normal,
            forced_width  = 5,
            color         = {
                type = "linear",
                from = { 0, 10 },
                to = { 10, 0 },
                stops = {
                    { 0, beautiful.fg_minimize },
                    { 1, beautiful.bg_urgent }
                }
            }
        },
        left = 0, right = 1, top = 1, bottom = 0,
        layout = wibox.container.margin
    },
    layout = wibox.layout.fixed.horizontal
}

-- Register battery widget
vicious.register(mybat, vicious.widgets.bat, "$2", 30, "BAT0")

return batwidget
