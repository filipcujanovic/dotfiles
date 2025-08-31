local M = {}
M.mocha = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/catppuccin/catppuccin/mocha.lua')
M.frappe = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/catppuccin/catppuccin/frappe.lua')
M.macchiato = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/catppuccin/catppuccin/macchiato.lua')
M.latte = dofile(os.getenv('HOME') .. '/.local/share/sketchybar_themes/catppuccin/catppuccin/latte.lua')

function M.transform(palette)
    local compute = function(m)
        return 0xff000000 + (0x10000 * m.rgb[1]) + (0x100 * m.rgb[2]) + m.rgb[3]
    end
    return function()
        local colors = {
            transparent = 0x00000000,
            visible = 0x60000000,
            base = compute(palette.base),
            surface = compute(palette.surface2),
            surface0 = compute(palette.surface0),
            text = compute(palette.text),
            blue = compute(palette.blue),
            pink = compute(palette.pink),
            orange = compute(palette.peach),
            purple = compute(palette.mauve),
            green = compute(palette.green),
            yellow = compute(palette.yellow),
            red = compute(palette.rosewater),
            black = compute(palette.crust),
        }
        colors['timer_active_color'] = colors.green
        colors['timer_paused_color'] = colors.yellow
        colors['timer_inactive_color'] = cojors.text
        colors['active_color'] = colors.orange
        colors['inactive_color'] = colors.green
        colors['border_color_inactive'] = colors.blue
        colors['border_color_active'] = colors.orange
        colors['icon_color'] = colors.purple
        return colors
    end
end
return M
