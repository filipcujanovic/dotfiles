local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')
local utils = require('utils')

local resolution = utils.split_string(
    io.popen('osascript -e \'tell application "Finder" to get bounds of window of desktop\' | awk -F\', \' \'{print $3 " " $4}\''):read('*a'),
    '[^%s]+'
)

local current_track = io.popen(
    'osascript -e \'tell application "Spotify" to return artist of current track & " - " & name of current track\' | tr \'[:upper:]\' \'[:lower:]\''
):read('*a')
local current_state = io.popen('osascript -e \'tell application "Spotify" to get player state\''):read('*a'):gsub('%s+', '')
local current_volume = io.popen('osascript -e \'tell application "Spotify" to get sound volume\''):read('*a')

local get_max_chars = function(resolution_width)
    --return tonumber(resolution_width) > opts.laptop_resolution and 20 or opts.item_options.group_items and 10 or 12
    return opts.item_options.group_items and 20 or (tonumber(resolution_width) > opts.laptop_resolution and 20 or 12)
end

local media = sbar.add('item', 'media', {
    position = 'e',
    scroll_texts = true,
    updates = true,
    padding_left = 5,
    padding_right = 10,
    update_freq = 1,
    icon = {
        string = icons.media_icon,
        padding_right = 10,
        drawing = current_state == 'paused',
    },
    label = {
        color = opts.color.green,
        max_chars = get_max_chars(resolution[1]),
        string = current_state == 'paused' and '' or current_track,
    },
    background = {
        color = opts.color.transparent,
    },
    popup = {
        align = 'center',
        horizontal = true,
    },
})

sbar.add('item', {
    position = 'popup.' .. media.name,
    icon = {
        string = icons.previous,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = opts.color.transparent },
}):subscribe('mouse.clicked', function()
    sbar.exec('osascript -e \'tell application "Spotify" to previous track\'')
    media:set({ popup = { drawing = false } })
end)
local playpause = sbar.add('item', {
    position = 'popup.' .. media.name,
    icon = {
        string = current_state == 'paused' and icons.play or icons.pause,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = opts.color.transparent },
})
playpause:subscribe('mouse.clicked', function()
    sbar.exec('osascript -e \'tell application "Spotify" to playpause\'')
    media:set({ popup = { drawing = false } })
end)

sbar.add('item', {
    position = 'popup.' .. media.name,
    icon = {
        string = icons.next,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = opts.color.transparent },
}):subscribe('mouse.clicked', function()
    sbar.exec('osascript -e \'tell application "Spotify" to next track\'')
    media:set({ popup = { drawing = false } })
end)

media:subscribe('mouse.clicked', function()
    media:set({ popup = { drawing = 'toggle' } })
end)

media:subscribe('mouse.exited.global', function()
    media:set({ popup = { drawing = false } })
end)

local spotify_volume_slider = sbar.add('slider', 'spotify_volume_slider', 100, {
    position = 'popup.' .. media.name,
    updates = true,
    slider = {
        percentage = current_volume,
    },
})

spotify_volume_slider:subscribe('mouse.clicked', function(env)
    sbar.exec('osascript -e \'tell application "Spotify" to set sound volume to ' .. env.PERCENTAGE .. '\'')
end)

media:subscribe('spotify_change', function(env)
    local label = env.INFO.Artist .. ' - ' .. env.INFO.Name
    label = io.popen('echo "' .. label .. '" | tr "[:upper:]" "[:lower:]"'):read('*a')
    local icon_drawing = false

    if env.INFO['Player State'] == 'Playing' then
        playpause:set({ icon = { string = icons.pause } })
    elseif env.INFO['Player State'] == 'Paused' then
        icon_drawing = true
        label = ''
        playpause:set({ icon = { string = icons.play } })
    end

    media:set({
        label = {
            string = label,
        },
        icon = {
            drawing = icon_drawing,
        },
    })
end)

media:subscribe('display_change', function(env)
    resolution = utils.split_string(
        io.popen('osascript -e \'tell application "Finder" to get bounds of window of desktop\' | awk -F\', \' \'{print $3 " " $4}\''):read('*a'),
        '[^%s]+'
    )
    media:set({
        label = {
            max_chars = get_max_chars(resolution[1]),
        },
    })
end)

return {
    media = media,
}
