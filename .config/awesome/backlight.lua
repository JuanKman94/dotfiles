local wibox = require("wibox")
local awful = require("awful")

backlight_widget = wibox.widget.textbox()
backlight_widget:set_align("right")

function update_backlight(widget)
  local fd = io.popen("xbacklight -get")
  local status = fd:read("*all")
  fd:close()

  local backlight = tonumber(string.match(status, "(%d+)"))
  -- backlight = string.format("% 3d", backlight)

  -- starting colour
  local sr, sg, sb = 0x3F, 0x3F, 0x3F
  -- ending colour
  local er, eg, eb = 0xDC, 0xDC, 0xDC

  local ir = backlight * (er - sr) + sr
  local ig = backlight * (eg - sg) + sg
  local ib = backlight * (eb - sb) + sb
  interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)

  --backlight = "<span background='#" .. interpol_colour .. "'>Backlight: " .. backlight .. "%</span>"
  backlight = "<span>Backlight: " .. backlight .. "%</span> | "
  widget:set_markup(backlight)
end

update_backlight(backlight_widget)

mytimer = timer({ timeout = 1})
mytimer:connect_signal("timeout", function () update_backlight(backlight_widget) end)
mytimer:start()
