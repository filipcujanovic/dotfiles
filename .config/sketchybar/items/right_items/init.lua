local calendar_items = require('items.right_items.calendar')
local battery_items = require('items.right_items.battery')
local opts = require('opts')
local sbar = require('sketchybar')
local volume_items = require('items.right_items.volume')
local timer_items = require('items.right_items.timer')
local bracket = sbar.add('bracket', {
    volume_items.device_icon.name,
    volume_items.volume.name,
    --volume_items.volume_slider.name,
    battery_items.battery.name,
    battery_items.battery_icon.name,
    calendar_items.calendar.name,
    calendar_items.calendar_icon.name,
}, {
    background = opts.bracket_background,
})

local show_border = function(env)
    bracket:set({ background = { drawing = 'toggle' } })
end
local attach_to_event = function(table_of_items)
    for key, value in pairs(table_of_items) do
        value:subscribe('mouse.entered', show_border)
        value:subscribe('mouse.exited', show_border)
    end
end

--front_app attach_to_event(calendar_items)
-- attach_to_event(battery_items)
-- attach_to_event(volume_items)
