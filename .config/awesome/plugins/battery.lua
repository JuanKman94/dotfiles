local vicious = require("vicious")
local wibox = require("wibox")
local beautiful = require("beautiful")

mybat = wibox.widget.progressbar()

-- Create wibox with mybat
batbox = wibox.widget({
	{
		max_value     = 1,
		widget        = mybat,
		border_width  = 0.4,
		border_color  = "#6FC3DF",
		forced_height = 5,
		forced_width  = 10,
		color         = {
			type = "linear",
			from = { 0, 0 },
			to = { 0, 30 },
			stops = {
				{ 0, "#E6FFFF" },
				{ 1, "#0C141F" }
			}
		}
	},
	direction     = 'east',
	color         = beautiful.fg_widget,
	layout        = wibox.container.rotate,
})
batbox = wibox.container.margin(batbox, 1, 1, 1, 1)

-- Register battery widget
vicious.register(mybat, vicious.widgets.bat, "$2", 30, "BAT0")

return batbox
