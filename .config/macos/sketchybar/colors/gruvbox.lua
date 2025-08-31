local M = {}

M.gruvbox = {
    dark0_hard = '#1d2021',
    dark0 = '#282828',
    dark0_soft = '#32302f',
    dark1 = '#3c3836',
    dark2 = '#504945',
    dark3 = '#665c54',
    dark4 = '#7c6f64',
    light0_hard = '#f9f5d7',
    light0 = '#fbf1c7',
    light0_soft = '#f2e5bc',
    light1 = '#ebdbb2',
    light2 = '#d5c4a1',
    light3 = '#bdae93',
    light4 = '#a89984',
    bright_red = '#fb4934',
    bright_green = '#b8bb26',
    bright_yellow = '#fabd2f',
    bright_blue = '#83a598',
    bright_purple = '#d3869b',
    bright_aqua = '#8ec07c',
    bright_orange = '#fe8019',
    neutral_red = '#cc241d',
    neutral_green = '#98971a',
    neutral_yellow = '#d79921',
    neutral_blue = '#458588',
    neutral_purple = '#b16286',
    neutral_aqua = '#689d6a',
    neutral_orange = '#d65d0e',
    faded_red = '#9d0006',
    faded_green = '#79740e',
    faded_yellow = '#b57614',
    faded_blue = '#076678',
    faded_purple = '#8f3f71',
    faded_aqua = '#427b58',
    faded_orange = '#af3a03',
    dark_red_hard = '#792329',
    dark_red = '#722529',
    dark_red_soft = '#7b2c2f',
    light_red_hard = '#fc9690',
    light_red = '#fc9487',
    light_red_soft = '#f78b7f',
    dark_green_hard = '#5a633a',
    dark_green = '#62693e',
    dark_green_soft = '#686d43',
    light_green_hard = '#d3d6a5',
    light_green = '#d5d39b',
    light_green_soft = '#cecb94',
    dark_aqua_hard = '#3e4934',
    dark_aqua = '#49503b',
    dark_aqua_soft = '#525742',
    light_aqua_hard = '#e6e9c1',
    light_aqua = '#e8e5b5',
    light_aqua_soft = '#e1dbac',
    gray = '#928374',
}

M.dark = {
    bg0 = M.gruvbox.dark0,
    bg1 = M.gruvbox.dark1,
    bg2 = M.gruvbox.dark2,
    bg3 = M.gruvbox.dark3,
    bg4 = M.gruvbox.dark4,
    fg0 = M.gruvbox.light0,
    fg1 = M.gruvbox.light1,
    fg2 = M.gruvbox.light2,
    fg3 = M.gruvbox.light3,
    fg4 = M.gruvbox.light4,
    red = M.gruvbox.bright_red,
    green = M.gruvbox.bright_green,
    yellow = M.gruvbox.bright_yellow,
    blue = M.gruvbox.bright_blue,
    purple = M.gruvbox.bright_purple,
    aqua = M.gruvbox.bright_aqua,
    orange = M.gruvbox.bright_orange,
    neutral_red = M.gruvbox.neutral_red,
    neutral_green = M.gruvbox.neutral_green,
    neutral_yellow = M.gruvbox.neutral_yellow,
    neutral_blue = M.gruvbox.neutral_blue,
    neutral_purple = M.gruvbox.neutral_purple,
    neutral_aqua = M.gruvbox.neutral_aqua,
    dark_red = M.gruvbox.dark_red,
    dark_green = M.gruvbox.dark_green,
    dark_aqua = M.gruvbox.dark_aqua,
    gray = M.gruvbox.gray,
}
M.light = {
    bg0 = M.gruvbox.light0,
    bg1 = M.gruvbox.light1,
    bg2 = M.gruvbox.light2,
    bg3 = M.gruvbox.light3,
    bg4 = M.gruvbox.light4,
    fg0 = M.gruvbox.dark0,
    fg1 = M.gruvbox.dark1,
    fg2 = M.gruvbox.dark2,
    fg3 = M.gruvbox.dark3,
    fg4 = M.gruvbox.dark4,
    red = M.gruvbox.faded_red,
    green = M.gruvbox.faded_green,
    yellow = M.gruvbox.faded_yellow,
    blue = M.gruvbox.faded_blue,
    purple = M.gruvbox.faded_purple,
    aqua = M.gruvbox.faded_aqua,
    orange = M.gruvbox.faded_orange,
    neutral_red = M.gruvbox.neutral_red,
    neutral_green = M.gruvbox.neutral_green,
    neutral_yellow = M.gruvbox.neutral_yellow,
    neutral_blue = M.gruvbox.neutral_blue,
    neutral_purple = M.gruvbox.neutral_purple,
    neutral_aqua = M.gruvbox.neutral_aqua,
    dark_red = M.gruvbox.light_red,
    dark_green = M.gruvbox.light_green,
    dark_aqua = M.gruvbox.light_aqua,
    gray = M.gruvbox.gray,
}

function M.transform(palette, is_dark)
    local compute = function(m)
        return 0xff000000 + tonumber(m:sub(2), 16)
    end
    return function()
        local colors = nil
        if is_dark then
            colors = {
                transparent = 0x00000000,
                visible = 0x60000000,
                base = compute(palette.bg0),
                surface = compute(palette.fg0),
                surface0 = compute(palette.fg1),
                text = compute(palette.green),
                blue = compute(palette.blue),
                orange = compute(palette.orange),
                purple = compute(palette.purple),
                green = compute(palette.green),
                yellow = compute(palette.yellow),
                red = compute(palette.red),
                neutral_yellow = compute(palette.neutral_yellow),
                neutral_purple = compute(palette.neutral_purple),
                neutral_green = compute(palette.neutral_green),
                dark_green = compute(palette.dark_green),
            }
            colors['timer_active_color'] = colors.green
            colors['timer_paused_color'] = colors.yellow
            colors['timer_inactive_color'] = colors.blue
            colors['active_color'] = colors.orange
            colors['inactive_color'] = colors.green
            colors['border_color_inactive'] = colors.blue
            colors['border_color_active'] = colors.orange
            colors['icon_color'] = colors.blue
        else
            colors = {
                transparent = 0x00000000,
                visible = 0x60000000,
                base = compute(palette.bg0),
                surface = compute(palette.fg0),
                surface0 = compute(palette.fg1),
                text = compute(palette.neutral_green),
                blue = compute(palette.blue),
                orange = compute(palette.orange),
                purple = compute(palette.purple),
                green = compute(palette.neutral_green),
                yellow = compute(palette.yellow),
                red = compute(palette.red),
                neutral_yellow = compute(palette.neutral_yellow),
                neutral_purple = compute(palette.neutral_purple),
                neutral_green = compute(palette.neutral_green),
                dark_green = compute(palette.dark_green),
            }
            colors['timer_active_color'] = colors.green
            colors['timer_paused_color'] = colors.yellow
            colors['timer_inactive_color'] = colors.base
            colors['active_color'] = colors.neutral_yellow
            colors['inactive_color'] = colors.green
            colors['border_color_inactive'] = colors.green
            colors['border_color_active'] = colors.neutral_yellow
            colors['icon_color'] = colors.dark_green
        end

        return colors
    end
end
return M
