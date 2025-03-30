local opts = require('opts')
local sbar = require('sketchybar')
local utils = require('utils')

local focused_space = io.popen('aerospace list-workspaces --focused'):read('*a'):gsub('%s+', '')
local all_spaces = utils.split_string(io.popen('aerospace list-workspaces --all'):read('*a'), '[^%s]+')
local active_color = opts.color.active_color
local inactive_color = opts.color.inactive_color
local border_color_inactive = opts.color.base
local space_border_items = {}
local width = 25
local height = width

local get_space_padding = function(space)
    local paddings = {
        M = 2,
        D = 2,
        N = 2,
        S = 1,
    }

    return paddings[space] ~= nil and paddings[space] or 0
end

for counter, sid in pairs(all_spaces) do
    local border_color = sid == focused_space and active_color or border_color_inactive
    local label_color = sid == focused_space and active_color or inactive_color
    local space = sbar.add('item', {
        position = 'left',
        padding_left = 10,
        padding_right = counter == #all_spaces and 15 or 0,
        icon = { drawing = false },
        label = {
            align = 'center',
            padding_right = get_space_padding(sid),
            string = sid,
            font = opts.sf_pro_text_large,
            color = label_color,
            width = width,
        },
        background = {
            height = height,
            --border_width = 1,
            --border_color = border_color,
            --corner_radius = 5,
        },
    })
    space:subscribe('aerospace_workspace_change', function(env)
        if env.FOCUSED_WORKSPACE:sub(1, 1) == sid then
            space:set({
                background = { border_color = active_color },
                label = { color = active_color },
            })
        else
            space:set({
                background = { border_color = border_color_inactive },
                label = { color = inactive_color },
            })
        end
    end)
    space:subscribe('mouse.clicked', function(env)
        sbar.exec('aerospace workspace ' .. sid)
    end)
    table.insert(space_border_items, space.name)
end

return {
    space_border_items = space_border_items,
}
