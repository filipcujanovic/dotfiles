local opts = require('opts')
local sbar = require('sketchybar')

local calendar_items = require('items.right_items.calendar')
local keyboard_layout_items = require('items.right_items.keyboard-layout')
local battery_items = require('items.right_items.battery')
local volume_items = require('items.right_items.volume')
local timer_items = require('items.right_items.timer')
sbar.add('bracket', {
    calendar_items.calendar.name,
    timer_items.timer.name,
    battery_items.battery.name,
    volume_items.device_icon.name,
    volume_items.volume.name,
    keyboard_layout_items.keyboard_layout.name,
}, {
    background = opts.bracket_background_border,
})
