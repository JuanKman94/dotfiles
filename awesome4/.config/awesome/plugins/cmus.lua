local escape_f      = require("awful.util").escape
local wibox         = require("wibox")
local string        = { format = string.format,
                       gmatch = string.gmatch,
                       gsub = string.gsub,
                       match  = string.match }

local cmus          = { widget = wibox.widget.textbox() }
local host          = os.getenv("XDG_RUNTIME_DIR")
local cmd           = string.format("cmus-remote --query --server %s/cmus-socket", host)
local fd            = nil
local query         = nil

-- colors
local yellow        = "#FFFF00"
local blue          = "#19FFFF"

function cmus.update()
    fd            = io.popen(cmd)
    query         = fd:read("*all")
    fd:close()

    local status = {
        playing     = false,
        duration    = false,
        title       = false,
        artist      = false,
        album       = false,
        track       = false,
        continue    = false,
        shuffle     = false,
        repeat_pl   = false,
        file        = ""
    }

    for line in string.gmatch(query, "[^\n]+") do
        for module, value in string.gmatch(line, "([%w]+) (.*)$") do
            if module == 'file' then
                status.file = value
            elseif module == 'duration' then
                status.duration = tonumber(value)
            elseif module == 'status' then
                status.playing = value == "playing"
            else
                for k, v in string.gmatch(value, "([%w]+) (.*)$") do
                    if module == 'tag' then
                        if k == 'title' then status.title = v
                        elseif k == 'artist' then status.artist = v
                        elseif k == 'tracknumber' then status.track = v
                        end
                    elseif module == 'set' then
                        if k == 'continue' then status.continue = v == 'true'
                        elseif k == 'shuffle' then status.shuffle = v == 'true'
                        elseif k == 'repeat' then status.repeat_pl = v == 'true'
                        end
                    end
                end
            end
        end
    end

    display = "[<span color=\"" .. blue .. "\">"
    if status.repeat_pl then display = display .. "R" end
    if status.shuffle then display = display .. "S" end
    if status.continue then display = display .. "C" end
    display = display .. "</span>] "

    if status.artist then
        display = display .. status.artist .. " - " .. status.title
    elseif status.file ~= "" then
        -- everything between the full path and the file extension
        display = display .. status.file
        --display = display .. string.match(status.file, ".+/(.+)%..+$")
    end

    if not status.playing then
        display = "<span color=\"" .. yellow .. "\">" .. display .. "</span>"
    end

    if query == "" then
        cmus.widget:set_markup( "" )
    else
        display = string.gsub(display, "&", "&amp;")
        cmus.widget:set_markup( display .. " | " )
    end
end

cmus.update()
return cmus
