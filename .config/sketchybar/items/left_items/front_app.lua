local icon_map = require('icon_map')
local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local separator = sbar.add('item', 'separator', {
    padding_left = opts.item_options.group_items and 5 or 0,
    padding_right = 0,
    icon = {
        string = icons.separator,
        padding_right = 0,
        padding_left = 0,
    },
})

local label = opts.item_options.front_app.show_label
        and {
            string = '',
            font = opts.font.default,
            padding_left = opts.item_options.front_app.show_icon and 5 or 0,
            padding_right = 0,
        }
    or {}

local icon = opts.item_options.front_app.show_icon and {
    padding_right = 0,
    padding_left = 0,
    font = opts.font.front_app_icon,
} or {}

local front_app = sbar.add('item', 'front_app', {
    position = 'left',
    padding_left = -10,
    padding_right = 0,
    icon = icon,
    label = label,
})

front_app:subscribe('front_app_switched', function(env)
    label = opts.item_options.front_app.show_label and { string = string.lower(env.INFO) } or {}
    icon = opts.item_options.front_app.show_icon and icon_map.get_icon(env.INFO, true) or {}
    front_app:set({
        icon = icon,
        label = label,
    })
end)

front_app:subscribe('forced', function()
    sbar.exec('aerospace list-windows --focused', function(window)
        sbar.trigger('front_app_switched', {
            INFO = window:match('| ([^|]*) |'),
        })
    end)
end)

return {
    separator = separator,
    front_app = front_app,
}
