local mpd			= {
						widget	= widget({ type = "textbox", align = "right" }),
						update	= nil,
						pause	= nil,
						prev	= nil,
						next	= nil,
						player	= nil
					  }
local cmd			= "mpc status"
local fd			= nil
local output		= nil
local string		= {
						format = string.format,
						match = string.match,
						gmatch = string.gmatch,
						gsub = string.gsub
					  }

-- colors
local yellow        = "#FFFF00"
local blue          = "#19FFFF"

function mpd.update()
	fd			= io.popen(cmd)
	output		= fd:read("*all")
	fd:close()

	-- status
	local s = {
		playing				= 'off',
		random				= 'off',
		consume				= 'off',
		_repeat				= 'off', -- `repeat` is reserverd
		single				= 'off',
		song_percentage		= false,
		song				= ''
	}
    local markup = "&#9835;"

	-- when mpd is playing, `mpc status` returns 3 lines:
	-- 	* song
	-- 	* song status
	-- 	* mpd status
	for line in string.gmatch(output, "[^\n]+") do
		if line:find('^%[') then	-- song status
			s.playing, s.song_percentage = string.match(line, '^%[(%a+)%] .+ %((%d+)%%%)')
		elseif line:find('^volume:') then
			s._repeat, s.random, s.single, s.consume = line:match('repeat: (%a+)%s+random: (%a+)%s+single: (%a+)%s+consume: (%a+)')
		elseif line:find('^%a+ - ') then -- `<artist> - <song>`
			s.song = line
		end
	end

	markup = markup .. string.format(" [<span color=%q>", blue)
	if s.random == 'on' then markup = markup .. "Z" end
	if s.consume == 'on' then markup = markup .. "C" end
	if s._repeat == 'on' then markup = markup .. "R" end
	if s.single == 'on' then markup = markup .. "S" end
	markup = markup .. "</span>] "

	markup = markup .. string.gsub(s.song, '&', '&amp;')

	if not s.playing or s.playing ~= 'playing' then
		markup = string.format("<span color=%q>%s</span>", yellow, markup)
	end

	mpd.widget.text = markup
end

function mpd.stop()
    awful.util.spawn("mpc stop")
    mpd.update()
end
function mpd.toggle()
    awful.util.spawn("mpc toggle")
    mpd.update()
end
function mpd.prev()
    awful.util.spawn("mpc prev")
    mpd.update()
end
function mpd.next()
    awful.util.spawn("mpc next")
    mpd.update()
end
function mpd.player()
    awful.util.spawn("uxterm -title ncmpcpp -e ncmpcpp")
    mpd.update()
end

mpd.widget:buttons(awful.util.table.join(
    awful.button({ }, 4, mpd.next ),
    awful.button({ }, 5, mpd.prev ),
    awful.button({ }, 1, mpd.toggle )
))

return mpd
