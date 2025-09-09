local opts = require('opts')
local sbar = require('sketchybar')

local label_padding = {
    left = 5,
    right = 10,
}

local aerospace_mode = sbar.add('item', 'aerospace-mode', {
    drawing = false,
    position = 'left',
    padding_left = 0,
    padding_right = 0,
    label = {
        padding_left = label_padding.left,
        padding_right = label_padding.right,
    },
    updates = true,
})

aerospace_mode:subscribe('aerospace_mode_change', function(env)
    local is_main_mode = env.MODE == 'main'
    aerospace_mode:set({
        drawing = not is_main_mode,
        label = {
            string = env.MODE,
            color = is_main_mode and opts.color.inactive_color or opts.color.active_color,
        },
        background = {
            border_color = is_main_mode and opts.color.border_color_inactive or opts.color.border_color_active,
        },
    })
end)

aerospace_mode:subscribe('mouse.clicked', function(_)
    sbar.exec('aerospace reload-config')
end)

return {
    aerospace_mode = aerospace_mode,
}
