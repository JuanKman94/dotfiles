battery_widget = awful.widget.progressbar()

battery_widget:set_width(8)
battery_widget:set_height(10)
battery_widget:set_vertical(true)
battery_widget:set_background_color("#494B4F")
battery_widget:set_border_color(nil)

battery_widget:set_color({
    type = "linear",
    from = { 0, 0 },
    to = { 0, 10 },
    stops = {
        { 0, "AECF96" },
        { 0.5, "#88A175" },
        { 1, "#FF5656" }
    }
})

function battery_widget_init()
    local mytimer = timer({ timeout = 1})
    mytimer:connect_signal("timeout", function () update_battery(battery_widget) end)
    mytimer:start()

    return battery_widget
end

function update_battery(widget)
  local command = io.popen("amixer sget Master")
  local command_output = command:read("*all")
  command:close()

  local percentage = tonumber(command_output:match("(%d+)%%"))

  battery_widget:set_value(percentage)
end
