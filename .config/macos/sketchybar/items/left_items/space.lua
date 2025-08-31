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
local space_apps_items = {}

local item_padding = opts.item_options.group_items and {
    left = 5,
    right = -5,
} or {
    left = 5,
    right = 0,
}

local label_padding = opts.item_options.group_items and {
    left = 0,
    right = 0,
} or {
    left = 0,
    right = 5,
}

local icon_padding = opts.item_options.group_items and {
    right = 10,
    left = 0,
} or {
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
            visible_apps_string = visible_apps_string .. current_app.string
        else
            visible_apps_string = visible_apps_string .. ':default:'
        end
    end

    return visible_apps_string
end

local get_visible_apps_number = function(space_id)
    local number_of_apps = io.popen('aerospace list-windows --count --workspace ' .. space_id):read('*a'):match('%d+')
    return number_of_apps
end

local generate_app_icons_table = function(space_id)
    local visible_apps = utils.json.decode(io.popen('aerospace list-windows --json --workspace ' .. space_id):read('*a'))
    local visible_apps_table = {}
    for _, app in pairs(visible_apps) do
        local id = app['window-id']
        local current_app = icon_map.get_icon(app['app-name'])
        visible_apps_table[id] = { string = current_app.string, font = current_app.font }
    end
    return visible_apps_table
end

local get_focused_app = function()
    local result = io.popen('aerospace list-windows --focused --json'):read('*a')
    if string.find('No window is focused', result) ~= nil then
        return nil
    else
        return utils.json.decode(result)[1]
    end
end

local get_focused_workspace = function()
    return io.popen('aerospace list-workspaces --focused'):read('*a'):gsub('%s+', '')
end

local change_focused_app = function(workspace, space)
    if opts.item_options.space.app_focus then
        workspace = workspace == nil and get_focused_workspace() or workspace

        local focused_app = get_focused_app()
        local items_to_delete = {}
        if not focused_app or space_apps_items[focused_app['window-id']] ~= nil then
            sbar.exec('aerospace list-windows --all --format %{window-id} --json', function(result)
                for id, app in pairs(space_apps_items) do
                    local found = false
                    for _, current_app in ipairs(result) do
                        if id == current_app['window-id'] then
                            found = true
                            break
                        end
                    end
                    if not found then
                        table.insert(items_to_delete, id)
                    end
                    if focused_app ~= nil and id == focused_app['window-id'] then
                        app:set({
                            icon = {
                                color = opts.color.border_color_active,
                            },
                        })
                    else
                        app:set({
                            icon = {
                                color = opts.color.border_color_inactive,
                            },
                        })
                    end
                end

                for _, id in pairs(items_to_delete) do
                    sbar.exec('sketchybar --remove ' .. id)
                    space_apps_items[id] = nil
                end
                if #items_to_delete ~= 0 then
                    if get_visible_apps_number(workspace) == 0 then
                        space:set({
                            label = workspace,
                        })
                    end
                end
            end)
        else
            local current_app = icon_map.get_icon(focused_app['app-name'])
            local id = focused_app['window-id']
            local space_apps_item = sbar.add('item', tostring(id), {
                position = 'left',
                padding_left = item_padding.left,
                padding_right = item_padding.right,
                icon = {
                    string = current_app.string,
                    font = current_app.font,
                    color = opts.color.label_color,
                    padding_left = label_padding.left,
                },
            })
            space_apps_items[id] = space_apps_item
            sbar.exec('sketchybar --move ' .. id .. ' after ' .. workspace)
        end
    end
end

for index, space_id in pairs(all_spaces) do
    local label_color = space_id == focused_space and active_color or inactive_color
    local space_apps_string = generate_app_icons_string(space_id)
    local space_apps_table = generate_app_icons_table(space_id)
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
    if opts.item_options.space.app_focus then
        space_name = utils.count(space_apps_table) ~= 0 and space_id .. ' -' or space_id
        label = {
            align = 'center',
            padding_left = index == 1 and 10 or icon_padding.left,
            padding_right = icon_padding.right,
            string = space_name,
            font = opts.sf_pro_text_small,
            color = label_color,
        }
        icon = {}
    else
    end
    local space = sbar.add('item', space_id, {
        position = 'left',
        padding_left = item_padding.left,
        padding_right = item_padding.right,
        label = label,
        icon = icon,
    })

    if opts.item_options.space.app_focus then
        for id, active_app in pairs(space_apps_table) do
            local space_apps_item = sbar.add('item', tostring(id), {
                position = 'left',
                padding_left = item_padding.left,
                padding_right = item_padding.right,
                icon = {
                    drawing = utils.count(space_apps_table) ~= 0,
                    string = active_app.string,
                    font = active_app.font,
                    color = opts.color.icon_color,
                    padding_left = label_padding.left,
                    padding_right = index == #all_spaces and 15 or label_padding.right,
                },
            })
            table.insert(space_border_items, space_apps_item.name)
            space_apps_items[id] = space_apps_item
        end
    end
    if #all_spaces ~= index then
        separator.generate_seperator('left', { left = 5, right = 5 })
    end

    space:subscribe('aerospace_workspace_change', function(env)
        change_focused_app(env.FOCUSED_WORKSPACE)
        local active_conf = {
            icon = { color = active_color },
        }

        local inactive_conf = {
            icon = { color = inactive_color },
        }

        if opts.item_options.space.app_focus then
            active_conf = {
                background = { border_color = opts.color.border_color_active },
                label = { color = active_color },
            }

            inactive_conf = {
                background = { border_color = opts.color.border_color_inactive },
                label = { color = inactive_color },
            }
        end

        if env.FOCUSED_WORKSPACE == space_id then
            space:set(active_conf)
        else
            space:set(inactive_conf)
        end
    end)

    space:subscribe('custom_space_windows_change', function(_)
        change_focused_app()
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

if opts.item_options.group_items then
    sbar.add('bracket', space_border_items, {
        background = opts.bracket_background_border,
    })
end

return {
    space_border_items = space_border_items,
}
