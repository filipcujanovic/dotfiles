local opts = require('opts')
local sbar = require('sketchybar')
local utils = require('utils')

local focused_space = io.popen('aerospace list-workspaces --focused'):read('*a'):gsub('%s+', '')
local all_spaces = utils.split_string(io.popen('aerospace list-workspaces --all'):read('*a'), '[^%s]+')
local active_color = opts.color.active_color
local inactive_color = opts.color.inactive_color
local space_border_items = {}
local spaces = {}

for _, space_id in pairs(all_spaces) do
    local visible_apps_number = tonumber(io.popen('aerospace list-windows --count --workspace ' .. space_id):read('*a'))
    spaces[space_id] = { drawing = visible_apps_number ~= 0 }
    local space = sbar.add('item', space_id, {
        drawing = spaces[space_id].drawing,
        position = 'left',
        padding_left = 0,
        padding_right = 0,
        label = {
            align = 'center',
            string = space_id,
            font = opts.font.default,
            color = space_id == focused_space and active_color or inactive_color,
        },
    })

    space:subscribe('aerospace_workspace_change', function(env)
        visible_apps_number = tonumber(io.popen('aerospace list-windows --count --workspace ' .. space_id):read('*a'))
        spaces[space_id] = { drawing = visible_apps_number ~= 0 }
        local active_conf = {
            drawing = spaces[space_id].drawing,
            label = { color = active_color },
        }

        local inactive_conf = {
            drawing = spaces[space_id].drawing,
            label = { color = inactive_color },
        }

        if env.FOCUSED_WORKSPACE == space_id then
            if not spaces[space_id].drawing then
                active_conf['drawing'] = true
            end
            space:set(active_conf)
        else
            if not spaces[space_id].drawing then
                inactive_conf['drawing'] = false
            end
            space:set(inactive_conf)
        end
    end)

    space:subscribe('custom_space_windows_change', function(_)
        space:set({
            label = {
                string = space_id,
            },
        })
    end)

    space:subscribe('mouse.clicked', function(_)
        sbar.exec('aerospace workspace ' .. space_id)
    end)
    table.insert(space_border_items, space.name)
end

return {
    space_border_items = space_border_items,
}
