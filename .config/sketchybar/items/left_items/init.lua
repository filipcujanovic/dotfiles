local opts = require('opts')
local sbar = require('sketchybar')

local space_items = require('items.left_items.space')
if opts.item_options.front_app.enabled then
    local front_app_items = require('items.left_items.front_app')
end
--table.insert(space_items.space_border_items, front_app_items.front_app.name)
--table.insert(space_items.space_border_items, front_app_items.separator.name)
--table.insert(space_items.space_border_items, timer_items.timer.name)
--sbar.add('bracket', space_items.space_border_items, {
--    background = opts.bracket_background,
--})

--table.remove(space_items.space_border_items, #space_items.space_border_items)
--table.remove(space_items.space_border_items, #space_items.space_border_items)
-- table.remove(space_items.space_border_items, #space_items.space_border_items)

--sbar.add('bracket', space_items.space_border_items, {
--    background = opts.bracket_background_border,
--})
