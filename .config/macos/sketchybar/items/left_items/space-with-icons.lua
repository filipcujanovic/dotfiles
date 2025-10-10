local icon_map = require('icon_map')
local opts = require('opts')
local sbar = require('sketchybar')
local utils = require('utils')
local icons = require('icons')
local separator = require('items.right_items.separator')

local focused_space = io.popen('aerospace list-workspaces --focused'):read('*a'):gsub('%s+', '')
local all_spaces = utils.split_string(io.popen('aerospace list-workspaces --all'):read('*a'), '[^%s]+')
local active_color = opts.color.active_color
local inactive_color = opts.color.inactive_color
local space_border_items = {}

local item_padding = {
    left = 5,
    right = 0,
}

local label_padding = {
    left = 0,
    right = 5,
}

local icon_padding = {
    left = 10,
    right = 5,
}

local generate_app_icons_string = function(space_id)
    local visible_apps_command = io.popen('aerospace list-windows --format %{app-name} --workspace ' .. space_id):read('*a')
    local visible_apps = utils.split_string(visible_apps_command, '(.-)\n')
    local visible_apps_string = ''
    for _, app in pairs(visible_apps) do
        local current_app = icon_map.get_icon(app)
        if current_app.string ~= icons.viber then
            visible_apps_string = visible_apps_string .. ' ' .. current_app.string
        else
            visible_apps_string = visible_apps_string .. ':default:'
        end
    end

    return visible_apps_string
end

for index, space_id in pairs(all_spaces) do
    local label_color = space_id == focused_space and active_color or inactive_color
    local space_apps_string = generate_app_icons_string(space_id)
    local space_name = string.len(space_apps_string) ~= 0 and space_id .. ' -' or space_id
    local label = {
        drawing = string.len(space_apps_string) ~= 0,
        string = space_apps_string,
        font = opts.font.front_app_icon_small,
        color = opts.color.icon_color,
        padding_left = label_padding.left,
        padding_right = index == #all_spaces and 15 or label_padding.right,
    }
    local icon = {
        align = 'center',
        padding_left = index == 1 and 10 or icon_padding.left,
        padding_right = index == #all_spaces and string.len(space_apps_string) == 0 and 10 or icon_padding.right,
        string = space_name,
        font = opts.sf_pro_text_small,
        color = label_color,
    }
    local space = sbar.add('item', space_id, {
        position = 'left',
        padding_left = item_padding.left,
        padding_right = item_padding.right,
        label = label,
        icon = icon,
    })

    if #all_spaces ~= index then
        separator.generate_seperator('left', { left = 5, right = 5 })
    end

    space:subscribe('aerospace_workspace_change', function(env)
        local active_conf = {
            icon = { color = active_color },
        }

        local inactive_conf = {
            icon = { color = inactive_color },
        }

        if env.FOCUSED_WORKSPACE == space_id then
            space:set(active_conf)
        else
            space:set(inactive_conf)
        end
    end)

    space:subscribe('custom_space_windows_change', function(_)
        space_apps_string = generate_app_icons_string(space_id)
        space_name = string.len(space_apps_string) ~= 0 and space_id .. ' -' or space_id
        space:set({
            label = {
                drawing = string.len(space_apps_string) ~= 0,
                string = space_apps_string,
            },
            icon = {
                string = space_name,
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
