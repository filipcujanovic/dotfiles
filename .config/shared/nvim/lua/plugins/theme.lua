return {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
        require('gruvbox').setup({
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
            overrides = {
                LineNr = { fg = '#b8bb26' },
                DashboardHeader = { fg = '#d65d0e' },
                DashboardKey = { fg = '#fb4934' },
                DashboardDesc = { fg = '#fabd2f' },
                DashboardIcon = { fg = '#83a598' },
                StatusLine = { fg = 'none', bg = 'none' },
                StatusLineNC = { fg = 'none', bg = 'none' },
                TabLine = { fg = 'none', bg = 'none' },
                TabLineFill = { fg = 'none', bg = 'none' },
                TabLineSel = { fg = 'none', bg = 'none' },
                WinBar = { fg = 'none', bg = 'none' },
                WinBarNC = { fg = 'none', bg = 'none' },
            },
            contrast = 'hard',
            transparent_mode = true,
            terminal_colors = true,
            component_separators = '',
            section_separators = '',
        })
        vim.cmd('colorscheme gruvbox')
    end,
}
