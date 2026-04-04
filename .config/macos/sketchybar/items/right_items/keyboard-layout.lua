local options = require('options')
local sbar = require('sketchybar')
local icons = require('icons')
local utils = require('utils')

sbar.add('event', 'keyboard_change', 'AppleSelectedInputSourcesChangedNotification')
local active_color = options.color.active_color
local inactive_color = options.color.inactive_color
local keyboard_layouts_full_path = {
    ['us'] = 'com.apple.keylayout.ABC',
    ['ć'] = 'com.apple.keylayout.Serbian-Latin',
    ['ћ'] = 'com.apple.keylayout.Serbian',
}
local keyboard_layouts = { 'us', 'ć', 'ћ' }

local get_current_keyboard_layout = function()
    local layout = io.popen('im-select | cut -d "." -f4'):read('*a'):gsub('%s+', ''):gsub('"', '')
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

local icon = options.item_options.keyboard_layout.enable_icon
        and {
            string = icons.keyboard,
            drawing = true,
            padding_right = 5,
            padding_left = 0,
        }
    or {}
local keyboard_layout_icon = icon

local current_keyboard_layout = get_current_keyboard_layout()
local current_active_index = utils.index_of(keyboard_layouts, current_keyboard_layout)
local keyboard_layout_item = sbar.add('item', 'keyboard_layout', {
    position = 'right',
    padding_left = 10,
    padding_right = 0,
    label = {
        string = current_keyboard_layout,
        color = options.color.green,
        padding_left = options.item_options.keyboard_layout.enable_icon and 5 or 0,
        padding_right = 0,
    },
    icon = next(keyboard_layout_icon) ~= nil and icon or {
        string = '-',
        font = options.font.default,
        color = options.color.green,
        padding_right = 10,
    },
    updates = true,
})

local show_all_keyboard_layouts = function(env)
    if env.INFO.button_code == 0 then
        keyboard_layout_item:set({ popup = { drawing = 'toggle' } })
    elseif env.INFO.button_code == 1 then
        current_active_index = current_active_index + 1
        if current_active_index > #keyboard_layouts then
            current_active_index = 1
        end
        sbar.exec(string.format('im-select %s', keyboard_layouts_full_path[keyboard_layouts[current_active_index]]))
    end
end

for index, keyboard_layout in pairs(keyboard_layouts) do
    local keyboard_layout_popup = sbar.add('item', keyboard_layout, {
        position = 'popup.' .. keyboard_layout_item.name,
        icon = keyboard_layout_icon,
        label = {
            string = keyboard_layout,
            padding_right = 5,
            padding_left = index ~= 1 and 10 or 5,
            color = keyboard_layout == current_keyboard_layout and active_color or inactive_color,
        },
        background = { color = options.color.transparent },
    })
    keyboard_layout_popup:subscribe('mouse.clicked', function()
        sbar.exec(string.format('im-select %s', keyboard_layouts_full_path[keyboard_layout]))
        keyboard_layout_item:set({ popup = { drawing = 'toggle' } })
        keyboard_layout_popup:set({ label = { color = active_color } })
        current_keyboard_layout = keyboard_layout
        current_active_index = index
    end)
    keyboard_layout_popup:subscribe('keyboard_change', function()
        keyboard_layout_popup:set({ label = { color = current_keyboard_layout == keyboard_layout_popup.name and active_color or inactive_color } })
    end)
end

keyboard_layout_item:subscribe('mouse.clicked', show_all_keyboard_layouts)
keyboard_layout_item:subscribe('mouse.exited.global', function()
    keyboard_layout_item:set({ popup = { drawing = false } })
end)

keyboard_layout_item:subscribe('keyboard_change', function()
    current_keyboard_layout = get_current_keyboard_layout()
    keyboard_layout_item:set({
        label = {
            string = current_keyboard_layout,
        },
    })
end)

return {
    keyboard_layout = keyboard_layout_item,
}
