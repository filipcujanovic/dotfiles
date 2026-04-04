local options = require('options')
local sbar = require('sketchybar')
local icons = require('icons')

local icon = options.item_options.calendar.enable_icon and {
    string = icons.calendar,
    padding_right = 5,
    padding_left = 0,
} or { drawing = false }
local date_is_visible = false
local date_format = options.item_options.calendar.show_full_date_time and '- %d - %B - %A - %H:%M:%S' or '- %A - %H:%M:%S'

local calendar = sbar.add('item', 'calendar', {
    position = 'right',
    padding_left = 10,
    padding_right = 5,
    update_freq = 1,
    label = {
        padding_left = 0,
        padding_right = 0,
    },
    icon = icon,
})

local function update_time()
    local date = string.lower(os.date(date_format))
    if calendar:query().scripting.update_freq == 0 then
        calendar:set({ update_freq = 1 })
    end
    calendar:set({ label = { string = date } })
end

local function print_date()
    if not date_is_visible then
        local date = string.lower(os.date('- %d - %B'))
        calendar:set({ label = { string = date }, update_freq = 0 })
    else
        update_time()
    end
    date_is_visible = not date_is_visible
end

local function open_calendar_app()
    sbar.exec('open -a Calendar')
end

local function calendar_click(env)
    if env.INFO.button_code == 0 then
        if options.item_options.calendar.show_full_date_time then
            open_calendar_app()
        else
            print_date()
        end
    elseif env.INFO.button_code == 1 and not options.item_options.calendar.show_full_date_time then
        open_calendar_app()
    end
end

calendar:subscribe('routine', update_time)
calendar:subscribe('forced', update_time)
calendar:subscribe('mouse.clicked', calendar_click)
if not options.item_options.calendar.show_full_date_time then
    calendar:subscribe('mouse.exited.global', update_time)
    calendar:subscribe('mouse.clicked', calendar_click)
end

return {
    calendar = calendar,
}
