local M = {}
M.day = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/tokyonight/extras/lua/tokyonight_day.lua')
M.moon = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/tokyonight/extras/lua/tokyonight_moon.lua')
M.night = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/tokyonight/extras/lua/tokyonight_night.lua')
M.storm = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/tokyonight/extras/lua/tokyonight_storm.lua')

function M.transform(palette)
	local compute = function(m)
		return 0xff000000 + tonumber(m:sub(2), 16)
	end
	return function()
		return {
			visible = 0x10000000,
			transparent = 0x00000000,
			base = compute(palette.bg),
			--visible = compute(palette.bg),
			surface = compute(palette.bg_highlight),
			surface0 = compute(palette.bg_highlight),
			text = compute(palette.purple),
			blue = compute(palette.blue),
			pink = compute(palette.magenta),
			orange = compute(palette.orange),
			purple = compute(palette.purple),
			green = compute(palette.green),
			yellow = compute(palette.yellow),
			red = compute(palette.red),
			black = compute(palette.black),
			timer_active_color = compute(palette.green),
			timer_paused_color = compute(palette.yellow),
			timer_inactive_color = compute(palette.purple),
			active_color = compute(palette.green),
			inactive_color = compute(palette.purple),
		}
	end
end
return M
