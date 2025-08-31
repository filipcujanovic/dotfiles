local colors = require('colors')

M = {}
M.color = colors.current

M.laptop_resolution = 1512
M.height = 37

M.item_options = {
    group_items = false,
    front_app = {
        enabled = true,
        show_icon = false,
        show_label = true,
    },
    battery = {
        enable_icon = false,
    },
    keyboard_layout = {
        enable_icon = false,
    },
    calendar = {
        enable_icon = false,
    },
    space = {
        -- this is still in progress
        -- currently it's too taxing for the process since it needs to do a lot of aerospace calls
        -- things that do not work pproperlyroperly
        -- 1. when removing an app the workspace label needs to be updated to remove
        -- 2. when moving an app from one workspace to another i need to move the item instead of removing
        -- probably need to create state data and check against that instead of querying aerospace
        app_focus = false,
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

M.font = {
    default = M.sf_pro_text,
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

M.bracket_background = {
    --color = M.color.surface0,
    --color = M.color.base,
    --color = M.color.transparent,
    height = 38,
}

M.background = {
    border_width = 1,
    border_color = M.color.border_color_inactive,
    corner_radius = 20,
    --padding_right = 5,
    --padding_left = 5,
}

M.bracket_background_border = {
    border_color = M.color.border_color_inactive,
    border_width = 1,
    height = 34,
    corner_radius = 50,
}

return M
