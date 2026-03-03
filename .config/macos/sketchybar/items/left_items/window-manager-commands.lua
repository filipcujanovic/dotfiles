local opts = require('opts')
local utils = require('utils')
local sbar = require('sketchybar')

if opts.window_manager.aerospace then
    return {
        get_focused_workspace = function()
            return io.popen('aerospace list-workspaces --focused'):read('*a'):gsub('%s+', '')
        end,
        get_workspaces_list = function()
            return utils.split_string(io.popen('aerospace list-workspaces --all'):read('*a'), '[^%s]+')
        end,
        get_window_chage_even_name = function()
            return 'aerospace_workspace_change'
        end,
        get_visible_apps_per_workspace = function(space_id)
            return tonumber(io.popen(string.format('aerospace list-windows --count --workspace %s', space_id)):read('*a'))
        end,
        move_focus_to_workspace = function(space_name, space_id)
            return sbar.exec(string.format('aerospace workspace %s', space_name))
        end,
        trigger_focused_window_event = function()
            sbar.exec('aerospace list-windows --focused', function(window)
                sbar.trigger('front_app_switched', {
                    INFO = window:match('| ([^|]*) |'),
                })
            end)
        end,
    }
end
if opts.window_manager.rift then
    return {
        get_focused_workspace = function()
            return io.popen('rift-cli query workspaces | jq -r ".[] | select(.is_active == true) | .name"'):read('*a'):gsub('%s+', '')
        end,
        get_workspaces_list = function()
            return utils.split_string(io.popen('rift-cli query workspaces | jq -r ".[] | .name"'):read('*a'), '[^%s]+')
        end,
        get_window_chage_even_name = function()
            return 'rift_workspace_changed'
        end,
        get_visible_apps_per_workspace = function(space_id)
            return tonumber(io.popen(string.format('rift-cli query workspaces | jq -r ".[] | select(.name == \\"%s\\") | .window_count"', space_id)):read('*a'))
        end,
        move_focus_to_workspace = function(space_name, space_id)
            return sbar.exec(string.format('rift-cli execute workspace switch %s', space_id - 1))
        end,
        trigger_focused_window_event = function()
            sbar.exec('rift-cli query windows | jq -r ".[] | select(.is_focused == true) | .app_name"', function(window)
                sbar.trigger('front_app_switched', {
                    INFO = window:match('| ([^|]*) |'),
                })
            end)
        end,
    }
end
