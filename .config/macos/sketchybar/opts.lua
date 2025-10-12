local colors = require('colors')

M = {}
M.color = colors.current

M.laptop_resolution = 1512
M.height = 37

M.item_options = {
    front_app = {
        enabled = false,
        show_icon = false,
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
    },
    spotify = {
        use_app = true,
    },
    space = {
        only_spaces_with_windows = true,
        with_icons = false,
    },
}

M.notch_width = {
    large = 200,
    small = 180,
    disabled = 0,
}

M.fira_code = {
    family = 'Fira Code Nerd Font',
    style = 'Medium',
    size = 16.0,
}

M.jet_brains = {
    family = 'JetBrainsMono Nerd Font',
    style = 'Medium',
    size = 16.0,
}

M.sf_pro_text = {
    family = 'SF Pro Text',
    style = 'Bold',
    size = 16.0,
}

M.sf_pro_text_small = {
    family = 'SF Pro Text',
    style = 'Bold',
    size = 15.0,
}

M.sf_pro_text_large = {
    family = 'SF Pro Text',
    style = 'Bold',
    size = 19.0,
}

M.victor_mono = {
    family = 'VictorMono Nerd Font',
    style = 'Bold',
    size = 16.0,
}

M.font = {
    default = M.victor_mono,
    icon_font_large = {
        family = 'Symbols Nerd Font Mono',
        style = 'Regular',
        size = 30.0,
    },
    icon_font_normal = {
        family = 'Symbols Nerd Font Mono',
        style = 'Regular',
        size = 20.0,
    },
    front_app_icon = {
        family = 'sketchybar-app-font',
        style = 'Regular',
        size = 22.0,
    },
    front_app_icon_small = {
        family = 'sketchybar-app-font',
        style = 'Regular',
        size = 15.0,
    },
    icon_font_small = {
        family = 'Symbols Nerd Font Mono',
        style = 'Regular',
        size = 15.0,
    },
}

return M
