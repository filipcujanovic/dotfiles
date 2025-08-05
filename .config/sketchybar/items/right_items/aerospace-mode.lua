local opts = require('opts')
local sbar = require('sketchybar')

local label_padding = opts.item_options.group_items and {
    left = 0,
    right = 0,
} or {
    left = 5,
    right = 10,
}

local aerospace_mode = sbar.add('item', 'aerospace-mode', {
    position = 'right',
    padding_left = 0,
    padding_right = 0,
    label = {
        string = 'main',
        padding_left = label_padding.left,
        padding_right = label_padding.right,
    },
    updates = true,
})

aerospace_mode:subscribe('aerospace_mode_change', function(env)
    local is_service_mode = env.MODE == 'service'
    aerospace_mode:set({
        label = {
            string = env.MODE,
            color = is_service_mode and opts.color.active_color or opts.color.inactive_color,
        },
        background = {
            border_color = is_service_mode and opts.color.border_color_active or opts.color.border_color_inactive,
        },
    })
end)

return {
    aerospace_mode = aerospace_mode,
}
