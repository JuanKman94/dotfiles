battery_widget = awful.widget.progressbar()

battery_widget:set_width(8)
battery_widget:set_height(10)
battery_widget:set_vertical(true)
battery_widget:set_background_color(beautiful.bg_normal)
battery_widget:set_border_color(beautiful.border_normal)

-- battery_widget:set_color({
--     type = "linear",
--     from = { 0, 0 },
--     to = { 0, 10 },
--     stops = {
--         { 0.10, "#FF0000" },
--         { 0.15, "#00FF00" },
--         { 0.5, "#0000FF" },
--         { 1, "#000000" }
--     }
-- })

function battery_widget_init()
    update_battery(battery_widget)
    return battery_widget
end

function update_battery(widget)
    local command = io.popen("acpi -b", r)
    local state, percent = string.match(command:read(), 'Battery %d: (%w+), (%d+)%%')

    command:close()
    percent = tonumber(percent)/100

    if state == 'Discharging' then
        battery_widget:set_color('#CCCC00')

        if percent < 0.2 then
            battery_widget:set_color("#FF1A1A")
        elseif percent < 0.5 then
            battery_widget:set_color("#FFFF00")
        else
            battery_widget:set_color("#00FF00")
        end
    elseif state == 'Charging' then
        battery_widget:set_color('#66CC00')
    else
        battery_widget:set_color("#0F0")
    end

    battery_widget:set_value(percent)
end

--battery_widget = awful.widget.progressbar()
--battery_widget:set_border_color(theme.border_normal)
--battery_widget:set_background_color(theme.bg_normal)
--battery_widget:set_color(theme.bg_focus)
--battery_widget:set_width(50)
--
--mytimer = timer({ timeout = 30 })
--mytimer:connect_signal("timeout", function()
--                                      f = io.popen('acpi -b', r)
--                                      f:close()
--                                      percent = tonumber(percent)/100
--                                      if state == 'Discharging' then
--                                        battery_widget:set_color('#CCCC00')
--                                        if percent < 0.2 then
--                                          battery_widget:set_color(theme.bg_urgent)
--                                        end
--                                      elseif state == 'Charging' then
--                                        battery_widget:set_color('#66CC00')
--                                      else
--                                        battery_widget:set_color(theme.bg_focus)
--                                      end
--                                      battery_widget:set_value(percent)
--                                  end)
--mytimer:start()
--mytimer:emit_signal("timeout")
