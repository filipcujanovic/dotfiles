local icon_map = require('icon_map')
local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local separator = sbar.add('item', 'separator', {
    padding_left = 0,
    icon = {
        string = icons.separator,
        padding_right = 5,
    },
})
local front_app = sbar.add('item', 'front_app', {
    position = 'left',
    padding_left = 0,
    icon = {
        padding_right = 5,
        font = opts.font.front_app_icon,
    },
    label = {
        string = '',
        font = opts.font.default,
        padding_left = 5,
        padding_right = 8,
    },
})

front_app:subscribe('front_app_switched', function(env)
    front_app:set({
        icon = icon_map.get_icon(env.INFO),
        label = {
            string = env.INFO,
        },
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
