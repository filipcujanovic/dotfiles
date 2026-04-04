local options = require('options')
local sbar = require('sketchybar')
local utils = require('utils')
local icons = require('icons')
local active_color = options.color.active_color
local inactive_color = options.color.inactive_color
local current_device = io.popen('SwitchAudioSource -c -t output'):read('*a'):gsub('^%s*(.-)%s*$', '%1')
local all_devices = utils.split_string(io.popen('SwitchAudioSource -a -t output'):read('*a'), '[^\r\n]+')

local get_device_icon = function(device)
    device = string.lower(device)
    if string.match(device, 'macbook pro') then
        return {
            string = icons.laptop,
        }
    end

    if string.match(device, 'airpods') then
        return {
            string = icons.airpods,
        }
    end

    if string.match(device, 'emberton') or string.match(device, 'dock') or string.match(device, 'headphone jack') then
        return {
            string = icons.speaker,
            padding_left = 10,
        }
    end

    if string.match(device, 'headphone') then
        return {
            string = icons.headphones,
        }
    end

    if string.match(device, 'eh11') then
        return {
            string = icons.headphones,
        }
    end

    if string.match(device, 'mac mini') then
        return {
            string = icons.mac_mini,
        }
    end

    return {
        string = icons.monitor,
    }
end

local get_device_string = function(device)
    device = string.lower(device)
    if string.match(device, 'headphone jack') then
        return 'headphone jack adapter'
    end
    return device
end

local current_device_icon = get_device_icon(current_device).string

local volume = sbar.add('item', 'volume', {
    position = 'right',
    padding_left = 0,
    padding_right = 0,
    label = {
        padding_right = 0,
        padding_left = 0,
    },
    icon = {
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

local device = sbar.add('item', 'device', {
    position = 'right',
    padding_left = 0,
    padding_right = 0,
    icon = {
        font = options.font.default,
        string = '-',
        color = options.color.green,
        padding_left = 0,
        padding_right = 5,
    },
    label = {
        string = current_device_icon,
    },
    popup = {
        align = 'center',
    },
})

local volume_changed = function(env)
    local icon = icons.volume_mute
    local volume_level = tonumber(env.INFO)
    if options.item_options.volume.enable_dynamic_icon then
        if volume_level > 68 then
            icon = icons.volume_full
        elseif volume_level > 31 then
            icon = icons.volume_50
        elseif volume_level > 5 then
            icon = icons.volume_25
        end
        volume:set({
            icon = {
                string = icon,
                padding_right = 5,
                drawing = true,
            },
        })
    else
        volume:set({
            label = {
                string = string.format('%s%%', volume_level),
            },
            icon = {
                string = '-',
                font = options.font.default,
                color = options.color.green,
                padding_right = 10,
            },
        })
    end
    volume_slider:set({
        slider = {
            percentage = env.INFO,
        },
    })
end

local toggle_volume_popup = function(env)
    volume:set({ popup = { drawing = 'toggle' } })
end

local change_device = function()
    current_device = io.popen('SwitchAudioSource -c -t output'):read('*a'):gsub('^%s*(.-)%s*$', '%1')
    current_device_icon = get_device_icon(current_device).string
    device:set({
        icon = {
            string = '-',
        },
        label = {
            string = current_device_icon,
        },
    })
end

local show_device_battery_level = function()
    if string.match(current_device, 'AirPods') then
        sbar.exec(
            'system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq -rc \'.SPBluetoothDataType[0].device_connected[] | select ( .[] | .device_minorType == "Headphones")\' | jq \'.[]\'',
            function(device_data, _)
                local battery_level_case = ''
                if device_data.device_batteryLevelCase ~= nil then
                    battery_level_case = icons.airpods_case .. device_data.device_batteryLevelCase
                end
                device:set({
                    label = {
                        string = icons.airpod_left
                            .. device_data.device_batteryLevelLeft
                            .. ' '
                            .. device_data.device_batteryLevelRight
                            .. icons.airpod_right
                            .. battery_level_case,
                    },
                })
            end
        )
    end
end

local hide_device_battery_level = function()
    device:set({
        label = get_device_icon(current_device),
    })
end

local create_popup_items = function()
    for _, input_device in pairs(all_devices) do
        local bar_device = sbar.add('item', input_device, {
            position = 'popup.' .. device.name,
            icon = get_device_icon(input_device),
            label = {
                string = get_device_string(input_device),
                padding_left = 20,
                color = input_device == current_device and active_color or inactive_color,
            },
            background = { color = options.color.transparent },
        })
        bar_device:subscribe('mouse.clicked', function()
            sbar.exec('SwitchAudioSource -s "' .. input_device .. '"')
            device:set({ popup = { drawing = 'toggle' } })
            device:set({ label = { string = get_device_icon(input_device).string } })
            current_device = input_device
        end)
        bar_device:subscribe('volume_change', function()
            bar_device:set({ label = { color = current_device == bar_device.name and active_color or inactive_color } })
        end)
    end
end

local handle_click = function(env)
    if env.INFO.button_code == 0 then
        device:set({ popup = { drawing = 'toggle' } })
    elseif env.INFO.button_code == 1 then
        show_device_battery_level()
    end
end

create_popup_items()

device:subscribe('mouse.clicked', handle_click)
device:subscribe('volume_change', change_device)
--device_icon:subscribe('mouse.entered', show_device_battery_level)
device:subscribe('mouse.exited', hide_device_battery_level)
device:subscribe('mouse.exited.global', function()
    device:set({ popup = { drawing = false } })
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

return {
    device = device,
    volume = volume,
    volume_slider = volume_slider,
}
