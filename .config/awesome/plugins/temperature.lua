local fgcool    = "#6FC3DF"
local fgmid     = "#FFE64D"
local fgcrit    = "#DF740C"

temper = {
    widget = widget({ type = "textbox" })
}

function temper.update()
    local cmd   = io.popen("sensors | grep 'temp1:'")
    local lines = cmd:read("*all")
    cmd:close()

    local count = 1
    local temps = {}
    local status = ""

    -- parse all the temperatures and store them in array
    for line in string.gmatch(lines, "[^\n]+") do
        temps[count] = { curr = nil, crit = nil }

        --temperatures = line:gmatch("[-+]%d+%.%d+")
        for t in line:gmatch("[-+]%d+%.%d+") do
            if not temps[count]['curr'] then
                temps[count]['curr'] = t
            else
                temps[count]['crit'] = t
            end
        end

        count = count + 1
    end

    -- print results to status string
    for index, dict in ipairs(temps) do
        local curr, crit = tonumber(dict['curr']), tonumber(dict['crit'])
        local scurr, scrit, color = "", "", ""

        -- pseudo-heuristic to determine color
        if curr <= (crit - 16) then color = fgcool
        elseif curr <= (crit - 10) then color = fgmid
        else color = fgcrit
        end

        scurr = string.format("<span color=%q>%3.1f°C</span>", color, curr)

        if crit then
            scrit = string.format("<span color=%q>%d°C</span>", fgcrit, crit)
        end

        -- update status string
        status = string.format("%s %s/%s", status, scurr, scrit)
    end

    temper.widget.text = status
end

return temper
