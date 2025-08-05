local sbar = require('sketchybar')

local display_watcher
local battery_watcher
local woke_watcher
local battery = {
    percentage = 100,
    charging = false,
}

local function update_display(_)
    sbar.exec(
        'system_profiler SPDisplaysDataType | grep -B 3 \'Main Display:\' | awk \'/Display Type/ {print $3}\' | grep -q \'Built-in\'',
        function(_, exit_code)
            if exit_code == 0 then
                sbar.trigger('builtin_display_change', { is_builtin = 'true' })
            else
                sbar.trigger('builtin_display_change', { is_builtin = 'false' })
            end
        end
    )
end

local function update_battery(_)
    sbar.exec('pmset -g batt | grep -Eo "\\d+%" | cut -d% -f1', function(percentage)
        if battery.percentage ~= percentage then
            battery.percentage = percentage
            sbar.trigger('battery_change', { percentage = percentage, charging = battery.charging })
        end
    end)
end

return {
    setup_events = function()
        sbar.add('event', 'aerospace_workspace_change')
        sbar.add('event', 'aerospace_mode_change')
        sbar.add('event', 'custom_space_windows_change')
        sbar.add('event', 'builtin_display_change')
        sbar.add('event', 'spotify_change', 'com.spotify.client.PlaybackStateChanged')
        sbar.add('event', 'battery_change')
        battery_watcher = sbar.add('item', {
            drawing = false,
            update_freq = 60,
        })
        display_watcher = sbar.add('item', {
            drawing = false,
            updates = true,
        })
    end,
    trigger_events = function()
        battery_watcher:subscribe('routine', update_battery)
        battery_watcher:subscribe('forced', update_battery)
        battery_watcher:subscribe('power_source_change', function(env)
            local charging = (env.INFO == 'AC')
            if battery.charging ~= charging then
                battery.charging = charging
                sbar.trigger('battery_change', { percentage = battery.percentage, charging = charging })
            end
        end)
    end,
}
