local colors = require('colors')
M = {}

M.color = colors.current
M.icon_font = 'Symbols Nerd Font Mono'
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
    size = 14.0,
}

M.sf_pro_text_large = {
    family = 'SF Pro Text',
    style = 'Bold',
    size = 19.0,
}

M.font = {
    default = M.sf_pro_text,
    icon_font_large = {
        family = M.icon_font,
        style = 'Regular',
        size = 30.0,
    },
    icon_font_small = {
        family = M.icon_font,
        style = 'Regular',
        size = 22.0,
    },
    front_app_icon = {
        family = 'sketchybar-app-font',
        style = 'Regular',
        size = 22.0,
    },
}

M.bracket_background = {
    --color = M.color.surface0,
    --color = M.color.base,
    color = M.color.transparent,
    height = 38,
}

M.bracket_background_border = {
    border_color = M.color.surface,
    border_width = 2,
    height = 34,
}

return M
