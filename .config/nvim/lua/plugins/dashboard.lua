return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup({
            theme = 'doom',
            config = {
                disable_move = {
                    enable = true,
                },
                week_header = {
                    enable = true,
                },
                header = {},
                center = {
                    {
                        action = 'SessionRestore',
                        desc = ' Restore Session',
                        icon = '󰦛',
                        key = 'r',
                    },
                    { action = 'Lazy update', desc = ' Update', icon = '󰚰', key = 'u' },
                    { action = 'FzfLua files', desc = ' Files', icon = '󰈞', key = 'f' },
                    { action = 'lua MiniFiles.open()', desc = ' Browse Files', icon = '', key = 'b' },
                    {
                        action = function()
                            vim.api.nvim_input('<cmd>qa<cr>')
                        end,
                        desc = ' Quit',
                        icon = '󰈆',
                        key = 'q',
                    },
                },
                footer = {},
            },
        })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
