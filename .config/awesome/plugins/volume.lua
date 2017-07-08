volume_cfg = {
    widget  = widget({ type = "textbox", align = "right" }),
    card_id = 0,
    channel = "Master"
}

-- command must start with a space!
volume_cfg.mixercommand = function (command)
       local fd = io.popen("amixer " .. command)
       local status = fd:read("*all")
       fd:close()
       local volume = string.match(status, "(%d?%d?%d)%%")
       volume = string.format("% 3d", volume)
       status = string.match(status, "%[(o[^%]]*)%]")

        local color = "#FF0000"
        if string.find(status, "on", 1, true) then
            color = "#00FF00"
        end
        status = ""
        for i = 1, math.floor(volume / 10) do
            status = status .. "|"
        end
        for i = math.floor(volume / 10) + 1, 10 do
            status = status .. "-"
        end
        status = "[" ..status .. "]"

        markup = " <span color=\"#00CC00\">-</span><span color=\"" .. color .. "\">" .. status .. "</span><span color=\"#19FFFF\">+</span>"

        volume_cfg.widget.text = markup
end

volume_cfg.update = function ()
       volume_cfg.mixercommand(" sget " .. volume_cfg.channel)
end

volume_cfg.up = function ()
       volume_cfg.mixercommand(" sset " .. volume_cfg.channel .. " 5%+")
end

volume_cfg.down = function ()
       volume_cfg.mixercommand(" sset " .. volume_cfg.channel .. " 5%-")
end

volume_cfg.toggle = function ()
       volume_cfg.mixercommand(" sset " .. volume_cfg.channel .. " toggle")
end

volume_cfg.widget:buttons(awful.util.table.join(
       awful.button({ }, 4, function () volume_cfg.up() end),
       awful.button({ }, 5, function () volume_cfg.down() end),
       awful.button({ }, 1, function () volume_cfg.toggle() end)
))

return volume_cfg
