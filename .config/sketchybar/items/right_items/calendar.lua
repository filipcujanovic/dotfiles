local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local calendar = sbar.add('item', 'calendar', {
    position = 'right',
    padding_left = 5,
    update_freq = 1,
    label = {
        padding_right = 5,
        padding_left = 5,
    },
    icon = {
        string = icons.calendar,
        padding_right = 5,
        padding_left = 5,
    },
    background = opts.use_border and opts.background or {},
})

--local calendar_icon = sbar.add('item', 'calendar_icon', {
--    position = 'right',
--    padding_right = 0,
--    padding_left = 5,
--    icon = {
--        string = icons.calendar,
--    },
--})

local function update_time()
    local date = os.date('%A %H:%M')
    if calendar:query().scripting.update_freq == 0 then
        calendar:set({ update_freq = 1 })
    end
    calendar:set({ label = { string = date } })
end

local function show_date()
    local date = os.date('%d %B')
    calendar:set({ label = { string = date }, update_freq = 0 })
end

calendar:subscribe('routine', update_time)
calendar:subscribe('forced', update_time)
calendar:subscribe('mouse.clicked', show_date)
calendar:subscribe('mouse.exited.global', update_time)
calendar:subscribe('mouse.clicked', function()
    sbar.exec('open -a "Calendar"')
end)
--calendar_icon:subscribe('mouse.clicked', function()
--    sbar.exec('open -a "Calendar"')
--end)

return {
    calendar = calendar,
}
