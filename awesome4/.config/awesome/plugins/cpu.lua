local io          = require("io")
local vicious     = require("vicious")
local wibox       = require("wibox")
local xresources  = require("beautiful.xresources")
local xrdb        = xresources.get_current_theme()
local format      = string.format
local fd          = io.popen("nproc")
local nproc       = tonumber(fd:read("*all"))
local cpu_values  = { 0, 0, 0, 0 }
local ctext       = wibox.widget.textbox()
local myarc       = wibox.widget {
                      {
                          widget = ctext
                      },
                      max_value = (nproc * 100),
                      values = cpu_values,
                      rounded_edge = false,
                      bg = xrdb.background,
                      widget = wibox.container.arcchart,
                      colors = {
                          xrdb.color1,
                          xrdb.color2,
                          xrdb.color3,
                          xrdb.color4,
                          xrdb.color5,
                          xrdb.color6,
                          xrdb.color7,
                          xrdb.color9,
                          xrdb.color10,
                          xrdb.color11,
                          xrdb.color12,
                          xrdb.color13,
                          xrdb.color14,
                          xrdb.color15,
                      }
                  }

fd:close()

vicious.register(ctext, vicious.widgets.cpu,
    function(wid, args)
        for i = 1, nproc do
            cpu_values[i] = args[i+1]
        end
        myarc:set_values( cpu_values )
        return ''
    end
)

return myarc
