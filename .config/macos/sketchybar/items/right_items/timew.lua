local options = require('options')
local sbar = require('sketchybar')
local icons = require('icons')

local get_current_timer = function()
    local tag = io.popen('timew | awk \'/^Tracking / {print $2}\''):read('*a'):gsub('%s+$', '')
    if string.len(tag) ~= 0 then
        local current_total_time = io.popen(string.format('timew summary %s :today | awk \'NF { last=$0 } END { print last }\' | xargs', tag)):read('*a')
        return string.format('%s - %s', tag, current_total_time)
    end
    return ''
end
local current_timer = get_current_timer()
local run_on_start = string.len(current_timer) ~= 0

local categories = { 'dotfiles', 'projects', 'stop', 'waste', 'work' }

local timew = sbar.add('item', 'timew', {
    position = 'right',
    padding_left = 0,
    padding_right = 0,
    label = {
        string = icons.timer,
        color = options.color.green,
        font = run_on_start and options.font.default or options.font.icon_font_normal,
        padding_right = 5,
        padding_left = 10,
    },
    icon = {
        font = options.font.default,
        string = '-',
        color = options.color.green,
        padding_left = 0,
        align = 'right',
    },
    updates = true,
    update_freq = run_on_start and 1 or 0,
    popup = {
        align = 'center',
    },
})

for _, category in ipairs(categories) do
    local category_item = sbar.add('item', 'timew' .. category, {
        position = 'popup.' .. timew.name,
        label = {
            string = category,
            padding_left = 20,
        },
        background = { color = options.color.transparent },
    })
    category_item:subscribe('mouse.clicked', function()
        if category == 'stop' then
            sbar.exec('timew stop | sketchybar --trigger timew-stop')
        else
            sbar.exec(string.format('timew start %s | sketchybar --trigger timew-start', category))
        end
        timew:set({ popup = { drawing = 'toggle' } })
    end)
end

local timew_start = function()
    timew:set({
        update_freq = 1,
    })
end

local timew_stop = function()
    timew:set({
        label = {
            font = options.font.icon_font_normal,
            string = icons.timer,
            color = options.color.green,
        },
        update_freq = 0,
    })
end

timew:subscribe('timew-start', timew_start)
timew:subscribe('timew-stop', timew_stop)

local update_timew = function()
    current_timer = get_current_timer()
    local color = options.color.orange
    if string.match(current_timer, 'waste') then
        color = options.color.red
    end
    if string.match(current_timer, 'dotfiles') then
        color = options.color.yellow
    end
    timew:set({
        label = {
            string = current_timer,
            color = color,
            font = options.font.default,
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

return timew
