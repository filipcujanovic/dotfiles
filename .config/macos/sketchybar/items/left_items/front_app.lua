local icon_map = require('icon_map')
local options = require('options')
local sbar = require('sketchybar')
local window_manager_commands = require('items.left_items.window-manager-commands')

local active_color = options.color.orange

local front_app = sbar.add('item', 'front_app', {
    position = 'left',
    padding_left = 0,
    padding_right = 0,
    icon = {
        color = active_color,
        padding_right = 0,
        padding_left = 0,
        font = options.font.default,
    },
    label = {
        string = '',
        font = options.font.default,
        padding_left = 5,
        padding_right = 10,
        color = active_color,
    },
})

front_app:subscribe('front_app_switched', function(env)
    if env.INFO ~= nil then
        local label = { string = string.format('%s', string.lower(env.INFO)) }
        local icon = icon_map.get_icon(string.lower(env.INFO), true)
        front_app:set({
            icon = icon,
            label = label,
        })
    end
end)

front_app:subscribe('forced', function()
    window_manager_commands.trigger_focused_window_event()
end)

return front_app
