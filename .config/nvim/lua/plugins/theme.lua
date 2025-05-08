--return {
--    'catppuccin/nvim',
--    lazy = false,
--    priority = 1000,
--    config = function()
--        local catppuccin = require('catppuccin')
--        catppuccin.setup({
--            transparent_background = true,
--            term_colors = true,
--            integrations = {
--                mason = true,
--                nvim_surround = true,
--                which_key = true,
--            },
--            highlight_overrides = {
--                all = function(colors)
--                    return {
--                        LineNr = { fg = colors.text },
--                    }
--                end,
--            },
--        })
--        vim.cmd.colorscheme('catppuccin-mocha')
--    end,
--}
return {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
        require('gruvbox').setup({
            overrides = {
                LineNr = { fg = '#b8bb26' },
                DashboardHeader = { fg = '#d65d0e' },
                DashboardKey = { fg = '#fb4934' },
                DashboardDesc = { fg = '#fabd2f' },
                DashboardIcon = { fg = '#83a598' },
            },
            contrast = 'hard',
            transparent_mode = true,
            terminal_colors = true,
        })
        vim.cmd('colorscheme gruvbox')
    end,
}
