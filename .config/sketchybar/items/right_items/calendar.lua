local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')
local utils = require('utils')

local label_padding = opts.item_options.group_items and {
    left = 0,
    right = 15,
} or {
    left = 10,
    right = 10,
}

local icon_padding = opts.item_options.group_items and {
    left = 0,
    right = 5,
} or {
    left = 10,
    right = -5,
}

local icon = opts.item_options.calendar.enable_icon
        and {
            string = icons.calendar,
            padding_right = icon_padding.right,
            padding_left = icon_padding.left,
        }
    or { drawing = false }
local date_is_visible = false

local calendar = sbar.add('item', 'calendar', {
    position = 'right',
    padding_left = opts.item_options.group_items and 0 or 5,
    padding_right = 0,
    update_freq = 1,
    label = {
        padding_left = label_padding.left,
        padding_right = label_padding.right,
    },
    icon = icon,
})

local function update_time()
    local date = string.lower(os.date('%A %H:%M'))
    if calendar:query().scripting.update_freq == 0 then
        calendar:set({ update_freq = 1 })
    end
    calendar:set({ label = { string = date } })
end

local function calendar_click(env)
    if env.INFO.button_code == 0 then
        if not date_is_visible then
            local date = string.lower(os.date('%d %B'))
            calendar:set({ label = { string = date }, update_freq = 0 })
        else
            update_time()
        end
        date_is_visible = not date_is_visible
    elseif env.INFO.button_code == 1 then
        sbar.exec('open -a Calendar')
    end
end

calendar:subscribe('routine', update_time)
calendar:subscribe('forced', update_time)
calendar:subscribe('mouse.clicked', calendar_click)

return {
    calendar = calendar,
}
