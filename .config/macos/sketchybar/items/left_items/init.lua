local options = require('options')

if options.item_options.space.with_icons then
    require('items.left_items.space-with-icons')
end
if options.item_options.space.only_spaces_with_windows then
    require('items.left_items.space')
end
if options.item_options.front_app.enabled then
    require('items.left_items.front_app')
end

require('items.left_items.aerospace-mode')
