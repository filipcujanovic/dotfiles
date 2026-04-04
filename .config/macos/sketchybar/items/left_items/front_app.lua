local utils = require('utils')
local icon_map = require('icon_map')
local options = require('options')
local sbar = require('sketchybar')
local icons = require('icons')
local window_manager_commands = require('items.left_items.window-manager-commands')
local active_color = options.color.green

local separator = sbar.add('item', 'separator', {
    padding_left = 0,
    padding_right = 0,
    icon = {
        string = icons.separator,
        padding_right = 0,
        padding_left = 0,
    },
})

local label = options.item_options.front_app.show_label
        and {
            string = '',
            font = options.font.default,
            padding_left = options.item_options.front_app.show_icon and 5 or 0,
            padding_right = 0,
            color = active_color,
        }
    or {}

local icon = options.item_options.front_app.show_icon
        and {
            color = active_color,
            padding_right = 0,
            padding_left = 10,
            font = options.font.front_app_icon,
        }
    or {}

local front_app = sbar.add('item', 'front_app', {
    position = 'left',
    padding_left = -10,
    padding_right = 0,
    icon = icon,
    label = label,
})

front_app:subscribe('front_app_switched', function(env)
    if env.INFO ~= nil then
        label = options.item_options.front_app.show_label and { string = string.lower(env.INFO) } or {}
        icon = options.item_options.front_app.show_icon and icon_map.get_icon(string.lower(env.INFO), true) or {}
        front_app:set({
            icon = icon,
            label = label,
        })
    end
end)

front_app:subscribe('forced', function()
    window_manager_commands.trigger_focused_window_event()
end)

return {
    separator = separator,
    front_app = front_app,
}
