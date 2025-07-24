local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local battery = sbar.add('item', 'battery', {
    position = 'right',
    label = {
        string = '%',
        font = opts.sf_pro_text_small,
        padding_right = 5,
        padding_left = 5,
    },
    icon = {
        align = 'center',
        padding_right = 5,
        padding_left = 5,
    },
    padding_right = 5,
    padding_left = 5,
    updates = true,
    background = opts.use_border and opts.background or {},
})

battery:subscribe('battery_change', function(env)
    battery:set({ label = { string = env.percentage .. '%' } })
    if env.charging == 'on' then
        battery:set({ icon = { string = icons.battery_charging } })
    else
        local icon = icons.battery_empty
        local p = tonumber(env.percentage)
        if p > 79 then
            icon = icons.battery_full
        elseif p > 59 then
            icon = icons.battery_75
        elseif p > 39 then
            icon = icons.battery_50
        elseif p > 19 then
            icon = icons.battery_25
        end
        battery:set({ icon = { string = icon } })
    end
end)

-- battery:subscribe("builtin_display_change", function(env)
-- 	battery:set({ drawing = env.is_builtin == "true" })
-- 	battery_icon:set({ drawing = env.is_builtin == "true" })
-- end)
return {
    battery = battery,
    battery_icon = battery_icon,
}
