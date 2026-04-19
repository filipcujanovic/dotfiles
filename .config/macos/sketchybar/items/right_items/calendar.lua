local options = require('options')
local sbar = require('sketchybar')
local icons = require('icons')

local icon = options.item_options.calendar.enable_icon and {
    string = icons.calendar,
    padding_right = 5,
    padding_left = 0,
} or { drawing = false }
local date_format = '- %x'

local calendar = sbar.add('item', 'calendar', {
    position = 'right',
    padding_left = 10,
    padding_right = 5,
    update_freq = 3600,
    label = {
        padding_left = 0,
        padding_right = 0,
    },
    icon = icon,
})

local function update_date()
    local date = string.lower(os.date(date_format))
    calendar:set({ label = { string = date } })
end

local function calendar_click(_)
    sbar.exec('open -a Calendar')
end

calendar:subscribe('routine', update_date)
calendar:subscribe('forced', update_date)
calendar:subscribe('mouse.clicked', calendar_click)

return calendar
