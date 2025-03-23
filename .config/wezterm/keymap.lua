local wezterm = require('wezterm')
local act = wezterm.action
return {
	{ key = 'i', mods = 'CTRL|CMD', action = act.QuickSelect },
}
