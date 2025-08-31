local sbar = require('sketchybar')
local opts = require('opts')

sbar.bar({
    height = opts.height,
    color = opts.color.visible,
    margin = 0,
    sticky = true,
    padding_left = 5,
    padding_right = 5,
    notch_width = opts.notch_width.small,
    display = 'main',
})

sbar.default({
    padding_left = 5,
    padding_right = 5,
    background = {
        height = 26,
        color = opts.color.transparent,
        corner_radius = 5,
    },
    icon = {
        color = opts.color.icon_color,
        font = opts.font.icon_font_normal,
        padding_left = 5,
        padding_right = 0,
    },
    label = {
        color = opts.color.text,
        font = opts.font.default,
        y_offset = 0,
        padding_left = 5,
        padding_right = 5,
    },
    popup = {
        background = {
            color = opts.color.base,
            corner_radius = 10,
        },
    },
    slider = {
        highlight_color = opts.color.orange,
        background = {
            height = 5,
            corner_radius = 3,
            color = opts.color.surface,
        },
        knob = {
            string = '􀀁',
            drawing = true,
            color = opts.color.red,
        },
    },
})
