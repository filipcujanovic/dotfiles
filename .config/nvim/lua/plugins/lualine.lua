return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local custom_gruvbox = require('lualine.themes.gruvbox_dark')
        custom_gruvbox.normal.c.bg = 'none'
        custom_gruvbox.insert.c.bg = 'none'
        custom_gruvbox.visual.c.bg = 'none'
        custom_gruvbox.command.c.bg = 'none'
        custom_gruvbox.replace.c.bg = 'none'
        custom_gruvbox.inactive.c.bg = 'none'

        custom_gruvbox.normal.c.fg = '#b8bb26'
        custom_gruvbox.insert.c.fg = '#b8bb26'
        custom_gruvbox.visual.c.fg = '#b8bb26'
        custom_gruvbox.command.c.fg = '#b8bb26'
        custom_gruvbox.replace.c.fg = '#b8bb26'
        custom_gruvbox.inactive.c.fg = '#b8bb26'
        require('lualine').setup({
            options = {
                icons_enabled = false,
                theme = custom_gruvbox,
            },
            sections = {
                lualine_x = {
                    --'kulala',
                    'encoding',
                    'fileformat',
                    'filetype',
                },
            },
        })
    end,
}
