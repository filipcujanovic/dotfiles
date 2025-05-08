local sbar = require('sketchybar')
local opts = require('opts')

sbar.bar({
    height = 37,
    color = opts.color.visible,
    margin = 0,
    sticky = true,
    padding_left = 5,
    padding_right = 5,
    notch_width = 220, -- resoulution 1512 x 982
    --notch_width = 188, -- resoulution 1512 x 982
    --notch_width = 145, -- resoulution 1352 x 878
    display = 'main',
})

sbar.default({
    padding_left = 10,
    padding_right = 10,
    background = {
        height = 26,
        color = opts.color.transparent,
        corner_radius = 5,
    },
    icon = {
        --catppuccin
        --color = opts.color.purple,
        --tokyo
        color = opts.color.blue,
        font = opts.font.icon_font_small,
        padding_left = 0,
        padding_right = 0,
    },
    label = {
        -- catppuccing
        --color = opts.color.orange,
        -- tokyo
        color = opts.color.text,
        font = opts.font.default,
        y_offset = 0,
        padding_left = 0,
        padding_right = 0,
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
