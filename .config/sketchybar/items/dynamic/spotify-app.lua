local opts = require('opts')
local sbar = require('sketchybar')
local icons = require('icons')

local current_track = io.popen(
    'osascript -e \'tell application "Spotify" to return artist of current track & " - " & name of current track\' | tr \'[:upper:]\' \'[:lower:]\''
):read('*a')
local current_state = io.popen('osascript -e \'tell application "Spotify" to get player state\''):read('*a'):gsub('%s+', '')
local current_volume = io.popen('osascript -e \'tell application "Spotify" to get sound volume\''):read('*a')

local media_icon = sbar.add('item', 'media_icon', {
    position = 'e',
    scroll_texts = true,
    updates = true,
    padding_left = 5,
    update_freq = 1,
    icon = {
        string = icons.media_icon,
        padding_right = 10,
    },
    label = {
        color = opts.color.green,
        max_chars = 24,
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
    position = 'popup.' .. media_icon.name,
    icon = {
        string = icons.previous,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = opts.color.transparent },
}):subscribe('mouse.clicked', function()
    sbar.exec('osascript -e \'tell application "Spotify" to previous track\'')
    media_icon:set({ popup = { drawing = false } })
end)
local playpause = sbar.add('item', {
    position = 'popup.' .. media_icon.name,
    icon = {
        string = current_state == 'pause' and icons.play or icons.pause,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = opts.color.transparent },
})
playpause:subscribe('mouse.clicked', function()
    sbar.exec('osascript -e \'tell application "Spotify" to playpause\'')
    media_icon:set({ popup = { drawing = false } })
end)

sbar.add('item', {
    position = 'popup.' .. media_icon.name,
    icon = {
        string = icons.next,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = opts.color.transparent },
}):subscribe('mouse.clicked', function()
    sbar.exec('osascript -e \'tell application "Spotify" to next track\'')
    media_icon:set({ popup = { drawing = false } })
end)

media_icon:subscribe('mouse.clicked', function()
    media_icon:set({ popup = { drawing = 'toggle' } })
end)

media_icon:subscribe('mouse.exited.global', function()
    media_icon:set({ popup = { drawing = false } })
end)

local spotify_volume_slider = sbar.add('slider', 'spotify_volume_slider', 100, {
    position = 'popup.' .. media_icon.name,
    updates = true,
    slider = {
        percentage = current_volume,
    },
})

spotify_volume_slider:subscribe('mouse.clicked', function(env)
    sbar.exec('osascript -e \'tell application "Spotify" to set sound volume to ' .. env.PERCENTAGE .. '\'')
end)

media_icon:subscribe('spotify_change', function(env)
    local label = env.INFO.Artist .. ' - ' .. env.INFO.Name
    label = io.popen('echo "' .. label .. '" | tr "[:upper:]" "[:lower:]"'):read('*a')

    if env.INFO['Player State'] == 'Playing' then
        playpause:set({ icon = { string = icons.pause } })
    elseif env.INFO['Player State'] == 'Paused' then
        label = ''
        playpause:set({ icon = { string = icons.play } })
    end

    media_icon:set({ label = { string = label } })
end)

return {
    media_icon = media_icon,
}
