local options = require('options')
local sbar = require('sketchybar')
local utils = require('utils')
local separator = require('items.separator')

local spaces
local front_app
local separator_item

if options.item_options.space.with_icons then
    spaces = require('items.left_items.space-with-icons')
end
if options.item_options.space.only_spaces_with_windows then
    spaces = require('items.left_items.space')
end
if options.item_options.front_app.enabled then
    separator_item = separator.generate_seperator('left', { left = 0, right = 15 }, true)
    front_app = require('items.left_items.front_app')
end

local aerospace_mode = require('items.left_items.aerospace-mode')

table.insert(spaces, front_app.name)
table.insert(spaces, separator_item.name)
table.insert(spaces, aerospace_mode.name)

sbar.add('bracket', spaces, {
    background = {
        color = options.color.base,
        corner_radius = 10,
        height = 30,
    },
})
