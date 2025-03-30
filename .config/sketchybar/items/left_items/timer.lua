local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')
local time_counter_file_path = '../files/time.txt'
local active_color = opts.color.timer_active_color
local paused_color = opts.color.timer_paused_color
local inactive_color = opts.color.timer_inactive_color

local read_file = function(file_path)
    local file = assert(io.open(time_counter_file_path, 'r'))
    local content = file:read('*a')
    file:close()
    return content
end

local write_to_file = function(file_path, content)
    local write_file = io.open(file_path, 'w')
    if write_file ~= nil then
        write_file:write(content)
        write_file:close()
    end
end

local get_time_string = function(time_in_seconds)
    local seconds = tostring(time_in_seconds % 60)
    local minutes = tostring(math.floor(((time_in_seconds - seconds) / 60) % 60))
    local hours = tostring(math.floor((time_in_seconds - seconds - (minutes * 60)) / 3600))
    hours = string.len(hours) == 1 and '0' .. hours or hours
    minutes = string.len(minutes) == 1 and '0' .. minutes or minutes
    seconds = string.len(seconds) == 1 and '0' .. seconds or seconds
    return hours .. ':' .. minutes .. ':' .. seconds
end

local time_counter = tonumber(read_file(time_counter_file_path))
time_counter = time_counter == nil and 0 or time_counter
local run_on_start = time_counter ~= 0

local timer = sbar.add('item', 'timer', {
    position = 'q',
    padding_right = 0,
    background = {
        color = opts.color.transparent,
    },
    label = {
        drawing = run_on_start,
        string = get_time_string(time_counter),
        color = run_on_start and active_color or inactive_color,
    },
    icon = {
        string = icons.clock,
        padding_right = 10,
    },
    updates = true,
    update_freq = run_on_start and 1 or 0,
    popup = {
        align = 'center',
        horizontal = true,
    },
})

sbar.add('item', {
    position = 'popup.' .. timer.name,
    icon = {
        string = icons.reset,
    },
    background = { color = opts.color.transparent },
}):subscribe('mouse.clicked', function()
    time_counter = 0
    write_to_file(time_counter_file_path, time_counter)
    timer:set({
        popup = { drawing = false },
        label = {
            string = get_time_string(time_counter),
            color = inactive_color,
        },
    })
end)
local playstop = sbar.add('item', {
    position = 'popup.' .. timer.name,
    icon = {
        string = icons.play,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = opts.color.transparent },
})
playstop:subscribe('mouse.clicked', function()
    local icon = icons.pause
    local update_freq = 1
    local color = active_color
    local drawing = true
    if timer:query().scripting.update_freq == 1 then
        update_freq = 0
        icon = icons.play
        color = paused_color
    end
    playstop:set({
        icon = { string = icon },
    })
    timer:set({
        popup = { drawing = false },
        label = { color = color, drawing = drawing },
        update_freq = update_freq,
    })
end)

local showhide = sbar.add('item', 'showhide', {
    position = 'popup.' .. timer.name,
    label = {
        color = opts.color.purple,
        padding_left = 10,
        padding_right = 10,
    },
    icon = {
        string = icons.show,
    },
    background = { color = opts.color.transparent },
})

showhide:subscribe('mouse.clicked', function()
    timer:set({
        label = {
            drawing = 'toggle',
        },
    })
    local icon = icons.show
    if showhide:query().label.drawing == 'on' then
        icon = icons.hide
    end
    showhide:set({
        icon = {
            string = icon,
        },
    })
end)

local function update_timer(env)
    playstop:set({ icon = { string = icons.pause } })
    timer:set({
        label = {
            string = get_time_string(time_counter),
        },
    })
    time_counter = time_counter + 1
    write_to_file(time_counter_file_path, time_counter)
end

timer:subscribe('mouse.exited.global', function()
    timer:set({ popup = { drawing = false } })
end)
timer:subscribe('routine', update_timer)
timer:subscribe('mouse.clicked', function()
    timer:set({ popup = { drawing = 'toggle' } })
end)

return {
    timer = timer,
}
