local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local calendar = sbar.add('item', 'calendar', {
    position = 'right',
    padding_left = 5,
    update_freq = 1,
    label = {
        padding_right = 5,
    },
})

local calendar_icon = sbar.add('item', 'calendar_icon', {
    position = 'right',
    padding_right = 0,
    icon = {
        string = icons.calendar,
        font = opts.font.icon_font_small,
    },
})

local function update_calendar()
    local date = os.date('%a %d %b %H:%M')
    calendar:set({ label = { string = date } })
end

calendar:subscribe('routine', update_calendar)
calendar:subscribe('forced', update_calendar)
calendar_icon:subscribe('mouse.clicked', function()
    sbar.exec('open -a "Calendar"')
end)

return {
    calendar = calendar,
    calendar_icon = calendar_icon,
}
