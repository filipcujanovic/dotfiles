local options = require('options')
local sbar = require('sketchybar')
local calendar = require('items.right_items.calendar')
local keyboard_layout = require('items.right_items.keyboard-layout')
local battery = require('items.right_items.battery')
local sound_device_items = require('items.right_items.sound_device')
local media_control = require('items.right_items.media-control')
local timew = require('items.right_items.timew')

sbar.add('bracket', {
    calendar.name,
    keyboard_layout.name,
    battery.name,
    sound_device_items.device.name,
    sound_device_items.volume.name,
    sound_device_items.volume_slider.name,
    media_control.name,
    timew.name,
}, {
    background = {
        color = options.color.base,
        corner_radius = 10,
    },
})
--require('items.right_items.spotify-app')
--require('items.right_items.spotify-player')
