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
                theme = custom_gruvbox,
            },
            sections = {
                lualine_a = {
                    {
                        require('noice').api.status.message.get_hl,
                        cond = require('noice').api.status.message.has,
                    },
                    {
                        require('noice').api.status.command.get,
                        cond = require('noice').api.status.command.has,
                    },
                    {
                        require('noice').api.status.mode.get,
                        cond = require('noice').api.status.mode.has,
                    },
                    {
                        require('noice').api.status.search.get,
                        cond = require('noice').api.status.search.has,
                    },
                },
                lualine_x = {
                    'kulala',
                    'encoding',
                    'fileformat',
                    'filetype',
                },
            },
        })
    end,
}
