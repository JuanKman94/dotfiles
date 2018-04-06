local math          = require("math")
local wibox         = require("wibox")
local vicious		= require("vicious")
local xresources	= require("beautiful.xresources")
local xrdb			= xresources.get_current_theme()
local ctext			= wibox.widget.textbox()
-- TODO: consider updating Xresources, try them on a terminal
local red_dark      = "#d4323f" -- color1
local red_light     = "#fdb73e" -- color9

local minutearc = wibox.widget {
    value = 59, min_value = 0, max_value = 59,
    colors = { red_dark },
    start_angle = 1.5*math.pi, thickness = 3,
    border_width = 0.5, border_color = red_light,
    widget = wibox.container.arcchart
}
local hourarc = wibox.widget {
    value = 11, min_value = 0, max_value = 11,
    colors = { xrdb.color14 },
    start_angle = 1.5*math.pi, thickness = 1,
    border_width = 0.5, border_color = xrdb.color6,
    widget = wibox.container.arcchart
}

local clockstack = wibox.widget({
    {
        minutearc,
        hourarc,
        layout = wibox.layout.stack
    },
    reflection = { horizontal = true, vertical = false },
    widget = wibox.container.mirror
})

--[[
-- TODO: find a vicious widget to get this done.
--       hopefully there's one that might get this done
vicious.register(ctext, vicious.widgets.date,
function(wid, args)
    -- args is the formatted date, e.g., 04:48
    hourarc:set_value( tonumber(args:sub(1,2)) )
    minutearc:set_value( tonumber(args:sub(4,5)) )
    return ''
end, 60, "%I:%M")
--]]

return clockstack
