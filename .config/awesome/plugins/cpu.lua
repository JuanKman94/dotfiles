local vicious		= require("vicious")
local wibox			= require("wibox")
local xresources	= require("beautiful.xresources")
local xrdb			= xresources.get_current_theme()
local format		= string.format
local cpu_values	= { 0, 0, 0, 0 }
local ctext			= wibox.widget.textbox()
local myarc			= wibox.widget {
						{
							widget = ctext
						},
						max_value = 400,
						values = cpu_values,
						rounded_edge = false,
						bg = xrdb.background,
						widget = wibox.container.arcchart,
						colors = {
							xrdb.color9,
							xrdb.color11,
							xrdb.color12,
							xrdb.color6,
						}
					}

vicious.register(ctext, vicious.widgets.cpu,
	function(wid, args)
		-- This is specific to the Thinkpad X220, which has 4 CPUs
		cpu_values[1] = args[2]
		cpu_values[2] = args[3]
		cpu_values[3] = args[4]
		cpu_values[4] = args[5]
		myarc:set_values( cpu_values )
		return ''
	end
)

return myarc
