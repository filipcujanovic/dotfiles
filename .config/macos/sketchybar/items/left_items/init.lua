local options = require('options')
local sbar = require('sketchybar')

local spaces
local front_app_items

if options.item_options.space.with_icons then
    spaces = require('items.left_items.space-with-icons')
end
if options.item_options.space.only_spaces_with_windows then
    spaces = require('items.left_items.space')
end
if options.item_options.front_app.enabled then
    front_app_items = require('items.left_items.front_app')
end

local aerospace_mode = require('items.left_items.aerospace-mode')

table.insert(spaces, front_app_items.front_app.name)
table.insert(spaces, front_app_items.separator.name)
table.insert(spaces, aerospace_mode.name)

sbar.add('bracket', spaces, {
    background = {
        color = options.color.base,
        corner_radius = 10,
    },
})
