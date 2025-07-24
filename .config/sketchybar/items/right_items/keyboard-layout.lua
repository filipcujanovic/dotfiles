local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')
local utils = require('utils')
local get_current_keyboard_layout = function()
    return io.popen(
        'defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev'
    )
        :read('*a')
        :gsub('%s+', '')
        :gsub('"', '')
end

local keyboard_layout = sbar.add('item', 'keyboard_layout', {
    position = 'right',
    label = {
        string = get_current_keyboard_layout(),
        font = opts.sf_pro_text_small,
        padding_right = 5,
    },
    icon = {
        string = icons.keyboard,
        padding_right = 5,
        padding_left = 5,
    },
    padding_right = 5,
    padding_left = 5,
    updates = true,
    background = opts.use_border and opts.background or {},
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
