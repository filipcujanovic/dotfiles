local icon_map = require('icon_map')
local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

return {
    generate_seperator = function(position, padding)
        if opts.item_options.group_items then
            sbar.add('item', {
                position = position,
                padding_right = 0,
                padding_left = 0,
                icon = {
                    --string = icons.separator,
                    --string = '❘',
                    --string = '|',
                    string = '│',
                    --string = '┃',
                    padding_right = padding.right,
                    padding_left = padding.left,
                },
                label = {
                    drawing = false,
                },
            })
        end
    end,
}
