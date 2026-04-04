local sbar = require('sketchybar')
local options = require('options')

sbar.bar({
    height = options.height,
    --color = options.color.dark,
    color = options.color.visible,
    margin = 0,
    sticky = true,
    padding_left = 5,
    padding_right = 5,
    notch_width = options.notch_width.small,
    display = 'main',
})

sbar.default({
    padding_left = 5,
    padding_right = 5,
    background = {
        height = 26,
        color = options.color.transparent,
        corner_radius = 5,
    },
    icon = {
        color = options.color.icon_color,
        font = options.font.icon_font_normal,
        padding_left = 5,
        padding_right = 0,
    },
    label = {
        color = options.color.text,
        font = options.font.default,
        y_offset = 0,
        padding_left = 5,
        padding_right = 5,
    },
    popup = {
        background = {
            color = options.color.base,
            corner_radius = 10,
        },
    },
    slider = {
        highlight_color = options.color.orange,
        background = {
            height = 5,
            corner_radius = 3,
            color = options.color.surface,
        },
        knob = {
            string = '􀀁',
            drawing = true,
            color = options.color.red,
        },
    },
})
