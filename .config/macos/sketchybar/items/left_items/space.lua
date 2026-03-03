local opts = require('opts')
local sbar = require('sketchybar')
local window_manager_commands = require('items.left_items.window-manager-commands')

local focused_space = window_manager_commands.get_focused_workspace()
local all_spaces = window_manager_commands.get_workspaces_list()
local active_color = opts.color.blue
local inactive_color = opts.color.red
local space_border_items = {}
local spaces = {}

for space_id, space_name in pairs(all_spaces) do
    local visible_apps_number = window_manager_commands.get_visible_apps_per_workspace(space_name)
    spaces[space_name] = { drawing = visible_apps_number ~= 0 }
    local space = sbar.add('item', space_name, {
        drawing = spaces[space_name].drawing,
        position = 'left',
        padding_left = 0,
        padding_right = 0,
        label = {
            align = 'center',
            string = space_name:sub(2),
            font = opts.font.default,
            padding_left = 0,
            color = space_name == focused_space and active_color or inactive_color,
        },
        icon = {
            font = opts.font.default,
            string = space_name:sub(1, 1),
            color = space_name == focused_space and active_color or opts.color.red,
        },
    })

    space:subscribe(window_manager_commands.get_window_chage_even_name(), function(env)
        visible_apps_number = window_manager_commands.get_visible_apps_per_workspace(space_name)
        spaces[space_name] = { drawing = visible_apps_number ~= 0 }
        local active_conf = {
            drawing = spaces[space_name].drawing,
            label = { color = active_color },
            icon = { color = active_color },
        }

        local inactive_conf = {
            drawing = spaces[space_name].drawing,
            label = { color = inactive_color },
            icon = { color = opts.color.red },
        }

        if env.FOCUSED_WORKSPACE == space_name then
            if not spaces[space_name].drawing then
                active_conf['drawing'] = true
            end
            space:set(active_conf)
        else
            if not spaces[space_name].drawing then
                inactive_conf['drawing'] = false
            end
            space:set(inactive_conf)
        end
    end)

    space:subscribe('custom_space_windows_change', function(_)
        space:set({
            label = {
                string = space_name,
            },
        })
    end)

    space:subscribe('mouse.clicked', function(_)
        window_manager_commands.move_focus_to_workspace(space_name, space_id)
    end)
    table.insert(space_border_items, space.name)
end

return {
    space_border_items = space_border_items,
}
