local icon_map = require('icon_map')
local opts = require('opts')
local sbar = require('sketchybar')
local utils = require('utils')
local icons = require('icons')

local focused_space = io.popen('aerospace list-workspaces --focused'):read('*a'):gsub('%s+', '')
local all_spaces = utils.split_string(io.popen('aerospace list-workspaces --all'):read('*a'), '[^%s]+')
local active_color = opts.color.active_color
local inactive_color = opts.color.inactive_color
local space_border_items = {}

local generate_app_icons_string = function(space_id)
    local visible_apps_command = io.popen('aerospace list-windows --format %{app-name} --workspace ' .. space_id):read('*a')
    local visible_apps = utils.split_string(visible_apps_command, '(.-)\n')
    local visible_apps_string = ''
    for _, app in pairs(visible_apps) do
        local current_app = icon_map.get_icon(app)
        if current_app.string ~= icons.viber then
            visible_apps_string = visible_apps_string .. current_app.string
        else
            visible_apps_string = visible_apps_string .. ':default:'
        end
    end

    return visible_apps_string
end

for _, space_id in pairs(all_spaces) do
    local border_color = space_id == focused_space and opts.color.border_color_active or opts.color.border_color_inactive
    local label_color = space_id == focused_space and active_color or inactive_color
    local space_apps = generate_app_icons_string(space_id)
    local space_name = string.len(space_apps) ~= 0 and space_id .. ' -' or space_id
    local space = sbar.add('item', {
        position = 'left',
        padding_left = 5,
        padding_right = 0,
        label = {
            drawing = string.len(space_apps) ~= 0,
            string = space_apps,
            font = opts.font.front_app_icon_small,
            color = opts.color.icon_color,
            padding_right = 5,
        },
        icon = {
            padding_left = 5,
            align = 'center',
            padding_right = 5,
            string = space_name,
            font = opts.sf_pro_text_small,
            color = label_color,
        },
        background = {
            --height = height,
            border_width = 1,
            border_color = border_color,
            corner_radius = 5,
        },
    })

    space:subscribe('aerospace_workspace_change', function(env)
        if env.FOCUSED_WORKSPACE == space_id then
            space:set({
                background = { border_color = opts.color.border_color_active },
                icon = { color = active_color },
            })
        else
            space:set({
                background = { border_color = opts.color.border_color_inactive },
                icon = { color = inactive_color },
            })
        end
    end)
    space:subscribe('custom_space_windows_change', function(_)
        space_apps = generate_app_icons_string(space_id)
        space_name = string.len(space_apps) ~= 0 and space_id .. ' -' or space_id
        space:set({
            label = {
                drawing = string.len(space_apps) ~= 0,
                string = space_apps,
            },
            icon = {
                string = space_name,
            },
        })
    end)
    space:subscribe('mouse.clicked', function(env)
        sbar.exec('aerospace workspace ' .. space_id)
    end)
    table.insert(space_border_items, space.name)
end

return {
    space_border_items = space_border_items,
}
