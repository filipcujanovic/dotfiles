return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        'MunifTanjim/nui.nvim',
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        --'rcarriga/nvim-notify',
    },
    config = function()
        require('noice').setup({
            presets = {
                bottom_search = false,
            },
            messages = {
                enabled = false,
            },
            notify = {
                enabled = true,
                view = 'mini',
            },
            lsp = {
                message = {
                    enabled = true,
                    view = 'mini',
                },
            },
            views = {
                -- This sets the position for the search popup that shows up with / or with :
                cmdline_popup = {
                    position = {
                        row = '40%',
                        col = '50%',
                    },
                },
                mini = {
                    timeout = 2000,
                    align = 'center',
                    position = {
                        -- Centers messages top to bottom
                        row = '95%',
                        -- Aligns messages to the far right
                        col = '100%',
                    },
                },
            },
        })
    end,
}
