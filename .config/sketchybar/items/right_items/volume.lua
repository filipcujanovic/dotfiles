local opts = require('opts')
local sbar = require('sketchybar')
local utils = require('utils')
local icons = require('icons')
local active_color = opts.color.active_color
local inactive_color = opts.color.inactive_color
local current_device = io.popen('SwitchAudioSource -c -t output'):read('*a'):gsub('^%s*(.-)%s*$', '%1')

local get_device_icon = function(device)
    local width = 30
    if string.match(device, 'MacBook Pro') then
        return {
            string = icons.laptop,
            width = width,
        }
    end
    if string.match(device, 'AirPods') then
        return {
            string = icons.airpods,
            width = width,
        }
    end
    if string.match(device, 'Headphones') then
        return {
            string = icons.headphones,
            width = width,
        }
    end

    return {
        string = icons.monitor,
        width = width,
    }
end

local volume = sbar.add('item', 'volume', {
    position = 'right',
    padding_left = 5,
    padding_right = 5,
    icon = {
        width = 25,
        align = 'center',
    },
    popup = {
        align = 'center',
    },
})

local volume_slider = sbar.add('slider', 'volume_slider', 220, {
    position = 'popup.' .. volume.name,
    updates = true,
})

local device_icon = sbar.add('item', 'device_icon', {
    position = 'right',
    padding_left = 5,
    padding_right = 0,
    icon = {
        string = get_device_icon(current_device).string,
        width = 30,
    },
    popup = {
        align = 'center',
    },
})

local volume_changed = function(env)
    local icon = icons.volume_mute
    local p = tonumber(env.INFO)
    if p > 68 then
        icon = '􀊦'
    elseif p > 31 then
        icon = icons.volume_50
    elseif p > 5 then
        icon = icons.volume_25
    end
    volume:set({
        icon = {
            string = icon,
        },
    })
    volume_slider:set({
        slider = {
            percentage = env.INFO,
        },
    })
end

local toggle_volume_popup = function(env)
    volume:set({ popup = { drawing = 'toggle' } })
end

local show_all_devices = function(env)
    local all_devices = utils.split_string(io.popen('SwitchAudioSource -a -t output'):read('*a'), '[^\r\n]+')
    local color = nil
    if sbar.query(device_icon.name).popup ~= nil then
        sbar.remove('/volume.device\\.*/')
    end
    for counter, device in pairs(all_devices) do
        color = inactive_color
        if device == current_device then
            color = active_color
        end
        local bar_device = sbar.add('item', 'volume.device.' .. counter, {
            position = 'popup.' .. device_icon.name,
            icon = get_device_icon(device),
            label = {
                string = device,
                padding_left = 20,
                color = color,
            },
            background = { color = opts.color.transparent },
        })
        bar_device:subscribe('mouse.clicked', function(env)
            sbar.exec('SwitchAudioSource -s "' .. device .. '"')
            device_icon:set({ popup = { drawing = 'toggle' } })
            device_icon:set({ icon = { string = get_device_icon(device).string } })
            current_device = device
        end)
    end
    device_icon:set({ popup = { drawing = 'toggle' } })
end

local change_device = function()
    current_device = io.popen('SwitchAudioSource -c -t output'):read('*a'):gsub('^%s*(.-)%s*$', '%1')
    device_icon:set({
        icon = get_device_icon(current_device),
    })
end

local show_device_battery_level = function()
    local width = 120
    if string.match(current_device, 'AirPods') then
        sbar.exec(
            'system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq -rc \'.SPBluetoothDataType[0].device_connected[] | select ( .[] | .device_minorType == "Headphones")\' | jq \'.[]\'',
            function(device_data, exit_code)
                local battery_level_case = ''
                if device_data.device_batteryLevelCase ~= nil then
                    battery_level_case = icons.airpods_case .. device_data.device_batteryLevelCase
                    width = 220
                end
                device_icon:set({
                    icon = {
                        string = icons.airpod_left
                            .. device_data.device_batteryLevelLeft
                            .. ' '
                            .. device_data.device_batteryLevelRight
                            .. icons.airpod_right
                            .. battery_level_case,
                        width = width,
                    },
                })
            end
        )
    end
end

local hide_device_battery_level = function()
    local icon_data = get_device_icon(current_device)
    icon_data.font = opts.font.icon_font_normal
    device_icon:set({
        icon = icon_data,
    })
end

device_icon:subscribe('mouse.clicked', show_all_devices)
device_icon:subscribe('volume', change_device)
device_icon:subscribe('volume_change', change_device)
device_icon:subscribe('mouse.entered', show_device_battery_level)
device_icon:subscribe('mouse.exited', hide_device_battery_level)
device_icon:subscribe('mouse.exited.global', function()
    device_icon:set({ popup = { drawing = false } })
end)

volume:subscribe('mouse.clicked', toggle_volume_popup)
volume:subscribe('mouse.exited.global', function()
    volume:set({ popup = { drawing = false } })
end)

volume_slider:subscribe('volume', volume_changed)
volume_slider:subscribe('volume_change', volume_changed)
volume_slider:subscribe('mouse.clicked', function(env)
    sbar.exec('osascript -e \'set volume output volume ' .. env.PERCENTAGE .. '\'')
end)

if opts.use_border then
    local bracket = sbar.add('bracket', {
        device_icon.name,
        volume.name,
    }, {
        background = opts.background,
    })
end

return {
    device_icon = device_icon,
    volume = volume,
    volume_slider = volume_slider,
}
