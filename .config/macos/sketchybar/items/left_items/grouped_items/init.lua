local opts = require('opts')

if opts.item_options.space.app_focus then
    require('items.left_items.grouped_items.space-with-app-focus')
end
if opts.item_options.space.with_icons then
    require('items.left_items.grouped_items.space-with-icons')
end
if opts.item_options.space.only_spaces_with_windows then
    require('items.left_items.grouped_items.space')
end
if opts.item_options.front_app.enabled then
    require('items.left_items.grouped_items.front_app')
end

require('items.left_items.grouped_items.aerospace-mode')
