local opts = require('opts')

if opts.item_options.group_items then
    require('items.right_items.grouped_items')
else
    require('items.right_items.calendar')
    require('items.right_items.keyboard-layout')
    require('items.right_items.battery')
    require('items.right_items.volume')
    require('items.right_items.timew')
end
