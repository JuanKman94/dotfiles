local math          = require("math")
local wibox         = require("wibox")
local vicious		= require("vicious")
local xresources	= require("beautiful.xresources")
local xrdb			= xresources.get_current_theme()
local gears         = require("gears")
local os            = require('os')
local ctext			= wibox.widget.textbox()
-- TODO: consider updating Xresources, try them on a terminal
local red_dark      = "#d4323f" -- color1
local red_light     = "#fdb73e" -- color9

local minutearc = wibox.widget {
    value = 59, min_value = 0, max_value = 60,
    colors = { xrdb.color14 },
    start_angle = 1.5*math.pi, thickness = 1,
    border_width = 0.5, border_color = xrdb.color6,
    widget = wibox.container.arcchart
}
local hourarc = wibox.widget {
    value = 0, min_value = 0, max_value = 12,
    colors = { red_dark },
    start_angle = 1.5*math.pi, thickness = 3.5,
    border_width = 0.5, border_color = red_light,
    widget = wibox.container.arcchart
}

local clockstack = wibox.widget({
    {
        hourarc,
        minutearc,
        layout = wibox.layout.stack
    },
    reflection = { horizontal = true, vertical = false },
    widget = wibox.container.mirror
})

vicious.register(
    ctext,
    function(format, warg)
        local values = {}
        local i = 1
        for d in os.date(warg and warg or "%I:%M:%S"):gmatch("(%d+)") do
            values[i] = tonumber(d)
            i = i+1
        end
        return values
    end,
    function(wid, args)
        hourarc.value = args[1] == 12 and 0 or args[1]
        minutearc.value = args[2]
        return string.gsub("$h:$m", "%$(%w)", { h = args[1], m = args[2] })
    end,
    60,
    "%I:%M"
)

return clockstack
