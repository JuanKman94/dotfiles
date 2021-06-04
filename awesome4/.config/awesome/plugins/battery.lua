local vicious    = require('vicious')
local wibox      = require('wibox')
local xresources = require('beautiful.xresources')
local table      = table
local xrdb       = xresources.get_current_theme()
local img        = wibox.widget.imagebox(
                    '/usr/share/icons/Adwaita/scalable/devices/battery-symbolic.svg',
                    true)
local widgets = {}
local batwidget = nil
local progressbar = nil

local create_battery_widget = function(bat_interface)
    progressbar = wibox.widget.progressbar()
    batwidget = wibox.widget {
        {
            img,
            forced_width = 16,
            left = 0, right = 4, top = 4, bottom = 0,
            layout = wibox.container.margin
        },
        {
            {
                {
                    widget        = progressbar,
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

    progressbar.background_color = xrdb.color9
    vicious.register(progressbar, vicious.widgets.bat, '$2', 30, bat_interface)

    return batwidget
end

table.insert(widgets, create_battery_widget('BAT0'))
table.insert(widgets, create_battery_widget('BAT1'))

return widgets
