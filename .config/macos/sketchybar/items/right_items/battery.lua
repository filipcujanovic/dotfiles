local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local battery = sbar.add('item', 'battery', {
    padding_left = 5,
    padding_right = 0,
    position = 'right',
    label = {
        string = '%',
        padding_left = 2,
        padding_right = 0,
    },
    icon = {
        padding_left = 0,
        padding_right = 5,
    },
    updates = true,
})

battery:subscribe('battery_change', function(env)
    battery:set({
        label = {
            string = env.percentage .. '%',
        },
        icon = {
            string = '',
        },
    })
    if opts.item_options.battery.enable_dynamic_icon then
        if env.charging == 'on' then
            battery:set({
                icon = {
                    string = icons.battery_charging,
                },
            })
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
    else
        if env.charging == 'on' then
            battery:set({
                icon = {
                    string = icons.charging,
                },
            })
        else
            battery:set({
                icon = {
                    string = icons.battery,
                },
            })
        end
    end
end)

return {
    battery = battery,
}
