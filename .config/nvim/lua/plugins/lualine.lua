return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = false,
                theme = 'gruvbox_dark',
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
