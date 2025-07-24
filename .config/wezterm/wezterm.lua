local wezterm = require('wezterm')
local keys = require('keymap')
local wallpaper = require('wallpaper')
local config = wezterm.config_builder()

config = {
    --background = wallpaper,
    keys = keys,
    max_fps = 120,
    font_size = 15,
    front_end = 'WebGpu',
    animation_fps = 120,
    enable_tab_bar = false,
    --background = wallpaper,
    default_cursor_style = 'SteadyBar',
    --enable_kitty_graphics = true,
    --term = 'xkitty-term',
    window_decorations = 'RESIZE',
    window_background_opacity = 0.7,
    color_scheme = 'GruvboxDarkHard',
    macos_window_background_blur = 25,
    window_close_confirmation = 'NeverPrompt',
    webgpu_power_preference = 'HighPerformance',
    font = wezterm.font('Liga SFMono Nerd Font'),
}

return config
