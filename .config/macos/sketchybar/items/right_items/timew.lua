local opts = require('opts')
local sbar = require('sketchybar')

local get_current_timer = function()
    return io.popen(
        'timew | awk \'/^There is no active time tracking.$/{exit} NR==1{sub($1" ", ""); task=$0} /Total/{time=$NF} END{if(task) print task, time}\''
    )
        :read('*a')
end
local current_timer = get_current_timer()
local run_on_start = string.len(current_timer) ~= 0

local timew = sbar.add('item', 'timew', {
    position = 'right',
    padding_left = 0,
    padding_right = 0,
    label = {
        font = opts.font.default,
        drawing = run_on_start,
        string = current_timer,
        color = opts.color.timer_active_color,
        padding_left = 0,
        padding_right = 0,
    },
    updates = true,
    update_freq = run_on_start and 1 or 0,
    popup = {
        align = 'center',
        horizontal = true,
    },
})

local timew_start = function()
    timew:set({
        label = {
            drawing = true,
        },
        update_freq = 1,
    })
end

local timew_stop = function()
    timew:set({
        label = {
            drawing = false,
        },
        update_freq = 0,
    })
end

timew:subscribe('timew-start', timew_start)
timew:subscribe('timew-stop', timew_stop)

local function update_timew()
    timew:set({
        label = {
            string = get_current_timer(),
        },
    })
end

timew:subscribe('mouse.exited.global', function()
    timew:set({ popup = { drawing = false } })
end)
timew:subscribe('routine', update_timew)
timew:subscribe('mouse.clicked', function()
    timew:set({ popup = { drawing = 'toggle' } })
end)

return {
    timew = timew,
}
