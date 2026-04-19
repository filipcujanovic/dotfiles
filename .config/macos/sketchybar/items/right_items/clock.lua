local options = require('options')
local sbar = require('sketchybar')
local icons = require('icons')

local icon = options.item_options.clock.enable_icon and {
    string = icons.clock,
    padding_right = 5,
    padding_left = 0,
} or {
    string = '-',
    font = options.font.default,
    padding_right = 10,
    color = options.color.green,
}
local time_format = '%H:%M:%S'

local clock = sbar.add('item', 'time', {
    position = 'right',
    padding_left = 0,
    padding_right = 10,
    update_freq = 1,
    label = {
        padding_left = 0,
        padding_right = 0,
        color = options.color.orange,
    },
    icon = icon,
})

local function update_time()
    local time = string.lower(os.date(time_format))
    clock:set({ label = { string = time } })
end

local function time_click(_)
    sbar.exec('open -a Clock')
end

clock:subscribe('routine', update_time)
clock:subscribe('forced', update_time)
clock:subscribe('mouse.clicked', time_click)

return clock
