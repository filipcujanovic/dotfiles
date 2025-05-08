return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    config = function()
        require('noice').setup({
            presets = {
                bottom_search = false,
            },
            messages = {
                enabled = true,
                view_search = false,
            },
            notify = {
                enabled = true,
                view = 'mini',
            },
            lsp = {
                message = {
                    enabled = true,
                },
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = '40%',
                        col = '50%',
                    },
                },
                mini = {
                    timeout = 20000,
                    --timeout = 2000,
                    align = 'center',
                    position = {
                        row = '95%',
                        col = '100%',
                    },
                },
            },
        })
    end,
}
