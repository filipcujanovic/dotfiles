local opts = require('opts')
local sbar = require('sketchybar')

return {
    generate_seperator = function(position, padding, drawing)
        return sbar.add('item', {
            drawing = drawing,
            position = position,
            padding_right = 0,
            padding_left = 0,
            icon = {
                --string = icons.separator,
                --string = '❘',
                --string = '|',
                string = '│',
                --string = '┃',
                --string = '|',
                padding_right = padding.right,
                padding_left = padding.left,
            },
            label = {
                drawing = false,
            },
        })
    end,
}
