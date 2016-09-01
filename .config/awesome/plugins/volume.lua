function volume_widget_init()
    local volume_widget = wibox.widget.textbox()
    volume_widget:set_align("right")

    update_volume(volume_widget)

    local mytimer = timer({ timeout = 1})
    mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
    mytimer:start()

    return volume_widget
end

function update_volume(widget)
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()

  local volume = tonumber(string.match(status, "%[(%d+)%%%]"))
  -- volume = string.format("% 3d", volume)

  -- starting colour
  local sr, sg, sb = 0x3F, 0x3F, 0x3F
  -- ending colour
  local er, eg, eb = 0xDC, 0xDC, 0xDC

  local ir = volume * (er - sr) + sr
  local ig = volume * (eg - sg) + sg
  local ib = volume * (eb - sb) + sb
  interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)

  if string.find(status, "off", 1, true) then
    volume = "<span color='red' background='#" .. interpol_colour .. "'>" .. volume .. "M</span> | "
  else
    volume = "<span background='#" .. interpol_colour .. "'>Vol: " .. volume .. "%</span> | "
  end
  widget:set_markup(volume)
end
