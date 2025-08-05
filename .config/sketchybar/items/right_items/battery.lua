local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local icon_padding = opts.item_options.group_items and {
    left = 0,
    right = 5,
} or {
    left = 5,
    right = 5,
}

local battery_icon = opts.item_options.battery.enable_icon
        and {
            align = 'center',
            padding_left = icon_padding.left,
            padding_right = icon_padding.right,
        }
    or {
        drawing = false,
        padding_left = 0,
        padding_right = 5,
    }

local label_padding = opts.item_options.group_items and {
    left = 0,
    right = 0,
} or {
    left = 5,
    right = 10,
}

local battery = sbar.add('item', 'battery', {
    padding_left = 0,
    padding_right = opts.item_options.group_items and 0 or 5,
    position = 'right',
    label = {
        string = '%',
        padding_left = label_padding.left,
        padding_right = label_padding.right,
    },
    icon = battery_icon,
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
    if opts.item_options.battery.enable_icon then
        if env.charging == 'on' then
            battery:set({
                icon = {
                    string = icons.battery_charging,
                    drawing = true,
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
                    drawing = true,
                    padding_left = opts.item_options.group_items and 0 or 10,
                },
            })
        else
            battery:set({
                icon = {
                    drawing = false,
                },
                label = {
                    padding_left = 10,
                },
            })
        end
    end
end)

return {
    battery = battery,
}
