local M = {}

M.ember = {
    base0 = '#151412',
    base1 = '#1c1b19',
    base2 = '#252422',
    base3 = '#2e2d2a',
    base4 = '#3e3c38',
    base5 = '#585550',
    base6 = '#706c61',
    base7 = '#908a7e',
    base8 = '#b8b0a0',
    bg = '#1c1b19',
    bg_alt = '#242320',
    coral = '#e08060',
    fg = '#d8d0c0',
    fg_alt = '#b0a898',
    gold = '#c8b468',
    mauve = '#988090',
    olive = '#8a9868',
    orange = '#c09058',
    rose = '#b07878',
    sage = '#80a090',
    steel = '#7890a0',
    type = 'dark',
}

function M.transform(palette)
    local compute = function(m)
        return 0xff000000 + tonumber(m:sub(2), 16)
    end
    return function()
        local colors = {
            transparent = 0x00000000,
            visible = 0x60000000,
            base = compute(palette.base0),
            dark = compute(palette.base0),
            surface = compute(palette.fg),
            surface0 = compute(palette.fg_alt),
            text = compute(palette.olive),
            blue = compute(palette.steel),
            orange = compute(palette.orange),
            purple = compute(palette.mauve),
            green = compute(palette.olive),
            yellow = compute(palette.gold),
            red = compute(palette.rose),
            neutral_yellow = compute(palette.coral),
            neutral_purple = compute(palette.mauve),
            neutral_green = compute(palette.olive),
            dark_green = compute(palette.olive),
        }
        colors['timer_active_color'] = colors.orange
        colors['timer_paused_color'] = colors.red
        colors['timer_inactive_color'] = colors.green
        colors['active_color'] = colors.orange
        colors['inactive_color'] = colors.green
        colors['border_color_inactive'] = colors.blue
        colors['border_color_active'] = colors.orange
        colors['icon_color'] = colors.red

        return colors
    end
end
return M
