local vicious    = require('vicious')
local wibox      = require('wibox')
local xresources = require("beautiful.xresources")
local xrdb       = xresources.get_current_theme()
local mybat      = wibox.widget.progressbar()
local img        = wibox.widget.imagebox(
                    '/usr/share/icons/Adwaita/scalable/devices/battery-symbolic.svg',
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
            {
                widget        = mybat,
                max_value     = 1,
                border_width  = 0.4,
                border_color  = xrdb.color1,
                forced_height = 5,
                color         = {
                    type = 'linear',
                    from = { 0, 0 },
                    to = { 15, 1 },
                    stops = {
                        { 0, xrdb.foreground },
                        { 1, xrdb.color7 }
                    }
                }
            },
            direction = 'east',
            layout = wibox.container.rotate
        },
        left = 0, right = 1, top = 1, bottom = 0,
        layout = wibox.container.margin
    },
    layout = wibox.layout.fixed.horizontal
}

mybat.background_color = xrdb.color9
-- Register battery widget
vicious.register(mybat, vicious.widgets.bat, '$2', 30, 'BAT0')

return batwidget
