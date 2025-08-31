local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')
local utils = require('utils')
local get_current_keyboard_layout = function()
    local layout = io.popen(
        'defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev'
    )
        :read('*a')
        :gsub('%s+', '')
        :gsub('"', '')
    if layout == 'ABC' then
        return 'us'
    end
    if layout == 'Serbian-Latin' then
        return 'ć'
    end
    if layout == 'Serbian' then
        return 'ћ'
    end

    return layout
end

local label_padding = opts.item_options.group_items and {
    left = 0,
    right = 0,
} or {
    left = opts.item_options.keyboard_layout.enable_icon and 5 or 10,
    right = 10,
}

local icon_padding = opts.item_options.group_items and {
    left = 0,
    right = 5,
} or {
    left = 10,
    right = 5,
}

local icon = opts.item_options.keyboard_layout.enable_icon
        and {
            string = icons.keyboard,
            drawing = true,
            padding_right = icon_padding.right,
            padding_left = icon_padding.left,
        }
    or { drawing = false }

local keyboard_layout = sbar.add('item', 'keyboard_layout', {
    position = 'right',
    padding_left = opts.item_options.group_items and 0 or 5,
    padding_right = 0,
    label = {
        string = get_current_keyboard_layout(),
        padding_left = label_padding.left,
        padding_right = label_padding.right,
    },
    icon = icon,
    updates = true,
})

sbar.add('event', 'keyboard_change', 'AppleSelectedInputSourcesChangedNotification')
keyboard_layout:subscribe('keyboard_change', function()
    keyboard_layout:set({
        label = {
            string = get_current_keyboard_layout(),
        },
    })
end)

return {
    keyboard_layout = keyboard_layout,
}
