local options = require('options')
local sbar = require('sketchybar')
local icons = require('icons')
local utils = require('utils')

local media = sbar.add('item', 'media', {
    position = 'right',
    scroll_texts = true,
    updates = true,
    padding_left = 10,
    padding_right = 10,
    update_freq = 1,
    icon = {
        padding_left = 0,
        padding_right = 0,
        string = icons.media_icon,
        drawing = false,
        color = options.color.green,
    },
    label = {
        padding_left = 0,
        padding_right = 0,
        color = options.color.orange,
        max_chars = 30,
        string = '',
    },
    popup = {
        align = 'center',
        horizontal = true,
    },
})

sbar.add('item', {
    position = string.format('popup.%s', media.name),
    icon = {
        string = icons.previous,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = options.color.transparent },
}):subscribe('mouse.clicked', function()
    sbar.exec('media-control prevous-track')
    media:set({ popup = { drawing = false } })
end)
local playpause = sbar.add('item', {
    position = string.format('popup.%s', media.name),
    icon = {
        string = '',
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = options.color.transparent },
})
playpause:subscribe('mouse.clicked', function()
    sbar.exec('media-control toggle-play-pause')
    media:set({ popup = { drawing = false } })
end)

sbar.add('item', {
    position = string.format('popup.%s', media.name),
    icon = {
        string = icons.next,
        padding_left = 10,
        padding_right = 10,
    },
    background = { color = options.color.transparent },
}):subscribe('mouse.clicked', function()
    sbar.exec('media-control next-track')
    media:set({ popup = { drawing = false } })
end)

media:subscribe('mouse.clicked', function()
    media:set({ popup = { drawing = 'toggle' } })
end)

media:subscribe('mouse.exited.global', function()
    media:set({ popup = { drawing = false } })
end)

media:subscribe('media_stream_changed', function(env)
    local artist = env.artist ~= nil and env.artist or ''
    local title = env.title ~= nil and env.title or ''
    local label = string.format('%s - %s', artist, title)
    label = io.popen(string.format('echo "%s" | LC_ALL=en_US.UTF-8 awk \'{print tolower($0)}\'', label)):read('*a')
    local icon_drawing = false

    if env.playing == 'true' then
        playpause:set({ icon = { string = icons.pause } })
    else
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

return {
    media = media,
}
