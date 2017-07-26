local string        = { format = string.format,
                       gmatch = string.gmatch,
                       gsub = string.gsub,
                       match  = string.match }

local cmus          = { widget = widget({ type = "textbox", align = "right" }) }
local cmd           = "cmus-remote --query"
local fd            = nil
local query         = nil

-- colors
local yellow        = "#FFFF00"
local blue          = "#19FFFF"

function cmus.update()
    fd            = io.popen(cmd)
    query         = fd:read("*all")
    fd:close()

    if string.match(query, 'cmus not running') then
        return
    end

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

    -- 'eighth note' character
    display = "&#9834;"


    if query == "" then
        cmus.widget.text = ""
    else
        display = display .. " [<span color=\"" .. blue .. "\">"
        if status.repeat_pl then display = display .. "R" end
        if status.shuffle then display = display .. "S" end
        if status.continue then display = display .. "C" end
        display = display .. "</span>] "

        if status.artist then
            display = display .. string.gsub(
                    status.artist .. " - " .. status.title,
                    '&',
                    '&amp;'
                )
        elseif status.file ~= "" then
            -- everything between the full path and the file extension
            display = display .. status.file
            --display = display .. string.match(status.file, ".+/(.+)%..+$")
        end

        if not status.playing then
            display = "<span color=\"" .. yellow .. "\">" .. display .. "</span>"
        end
    end

    cmus.widget.text = display
end

function cmus.pause()
    awful.util.spawn("cmus-remote --pause")
    cmus.update()
end

function cmus.prev()
    awful.util.spawn("cmus-remote --prev")
    cmus.update()
end

function cmus.next()
    awful.util.spawn("cmus-remote --next")
    cmus.update()
end

cmus.widget:buttons(awful.util.table.join(
    awful.button({ }, 4, cmus.next ),
    awful.button({ }, 5, cmus.prev ),
    awful.button({ }, 1, cmus.pause )
))

return cmus
