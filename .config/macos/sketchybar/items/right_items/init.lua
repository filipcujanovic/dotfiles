local opts = require('opts')
local seperator = require('items.right_items.separator')
local sbar = require('sketchybar')
local calendar_items = require('items.right_items.calendar')
seperator.generate_seperator('right', { left = 5, right = 10 })
local keyboard_layout_items = require('items.right_items.keyboard-layout')
seperator.generate_seperator('right', { left = 5, right = 10 })
local aerospace_mode_items = require('items.right_items.aerospace-mode')
seperator.generate_seperator('right', { left = 5, right = 5 })
local battery_items = require('items.right_items.battery')
seperator.generate_seperator('right', { left = 5, right = 5 })
local volume_items = require('items.right_items.volume')
seperator.generate_seperator('right', { left = 5, right = 5 })
local timer_items = require('items.right_items.timer')
if opts.item_options.group_items then
    local bracket = sbar.add('bracket', {
        calendar_items.calendar.name,
        timer_items.timer.name,
        battery_items.battery.name,
        volume_items.device_icon.name,
        volume_items.volume.name,
        keyboard_layout_items.keyboard_layout.name,
        aerospace_mode_items.aerospace_mode.name,
    }, {
        background = opts.bracket_background_border,
    })
end

--local show_border = function(env)
--    bracket:set({ background = { drawing = 'toggle' } })
--end
--local attach_to_event = function(table_of_items)
--    for key, value in pairs(table_of_items) do
--        value:subscribe('mouse.entered', show_border)
--        value:subscribe('mouse.exited', show_border)
--    end
--end

--front_app attach_to_event(calendar_items)
-- attach_to_event(battery_items)
-- attach_to_event(volume_items)
