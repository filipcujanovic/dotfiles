local colors = require('colors')

M = {}
M.color = colors.current

M.laptop_resolution = 1512
M.height = 37

M.item_options = {
    front_app = {
        enabled = true,
        show_icon = true,
        show_label = true,
    },
    volume = {
        enabled = true,
        enable_dynamic_icon = false,
    },
    battery = {
        enabled = true,
        enable_dynamic_icon = false,
    },
    keyboard_layout = {
        enabled = true,
        enable_icon = false,
    },
    calendar = {
        enabled = true,
        enable_icon = false,
        show_full_date_time = true,
    },
    spotify = {
        use_app = true,
    },
    space = {
        only_spaces_with_windows = true,
        with_icons = false,
    },
}

M.window_manager = {
    aerospace = true,
    rift = false,
}

M.notch_width = {
    large = 200,
    small = 180,
    disabled = 0,
}

local font_size = 18.0
local small_font_size = 15.0
local icon_font_size = 20.0
local large_icon_font_size = 30.0
local front_app_icon_size = 22.0

M.fonts = {
    fira_code = {
        family = 'Fira Code Nerd Font',
        style = 'Medium',
        size = font_size,
    },
    jet_brains = {
        family = 'JetBrainsMono Nerd Font',
        style = 'Medium',
        size = font_size,
    },
    sf_pro_text = {
        family = 'SF Pro Text',
        style = 'Medium',
        size = font_size,
    },
    sf_pro_text_small = {
        family = 'SF Pro Text',
        style = 'Bold',
        size = small_font_size,
    },
    victor_mono = {
        family = 'VictorMono Nerd Font',
        style = 'Bold',
        size = font_size,
    },
}

M.font = {
    default = M.fonts.jet_brains,
    icon_font_large = {
        family = 'Symbols Nerd Font Mono',
        style = 'Regular',
        size = large_icon_font_size,
    },
    icon_font_normal = {
        family = 'Symbols Nerd Font Mono',
        style = 'Regular',
        size = icon_font_size,
    },
    front_app_icon = {
        family = 'sketchybar-app-font',
        style = 'Regular',
        size = front_app_icon_size,
    },
    front_app_icon_small = {
        family = 'sketchybar-app-font',
        style = 'Regular',
        size = small_font_size,
    },
    icon_font_small = {
        family = 'Symbols Nerd Font Mono',
        style = 'Regular',
        size = small_font_size,
    },
}

return M
