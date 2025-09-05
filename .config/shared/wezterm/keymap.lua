local wezterm = require('wezterm')
local act = wezterm.action
local keymap = { { key = 'i', mods = 'CTRL|CMD', action = act.QuickSelect } }
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    table.insert(keymap, { key = 'v', mods = 'CTRL', action = act.PasteFrom('Clipboard') })
end
return keymap
