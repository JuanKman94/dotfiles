local awful = require('awful')
local string = { format = string.format }
local start_dir = {
    widget = awful.widget.prompt().widget
}

-- TODO: add `configure` method where we can override `dir` and `cmd_str`

start_dir.dir = '$HOME'
start_dir.cmd_str = '%s -e "if [ -d %q ]; then cd %q; else cd $HOME; fi; $SHELL -l"'

-- Spawn program after `cd`ing to `dir`
function start_dir.spawn(terminal)
    local cmd = string.format(start_dir.cmd_str,
        terminal,
        start_dir.dir,
        start_dir.dir
    )

    awful.spawn(cmd)
end

-- Set working directory for future `spawn`s
function start_dir.set()
    awful.prompt.run {
        prompt       = string.format('Working dir [%s]: ', start_dir.dir),
        textbox      = start_dir.widget,
        exe_callback = function(input) start_dir.dir = input end
    }
end

return start_dir
