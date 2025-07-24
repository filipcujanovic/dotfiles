local opts = require('opts')
local sbar = require('sketchybar')

local aerospace_mode = sbar.add('item', 'aerospace-mode', {
    position = 'right',
    label = {
        string = 'main',
        font = opts.sf_pro_text_small,
        padding_left = 5,
        padding_right = 5,
    },
    padding_right = 0,
    padding_left = 8,
    updates = true,
    background = opts.use_border and opts.background or {},
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
