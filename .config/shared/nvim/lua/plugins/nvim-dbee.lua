return {
    'kndndrj/nvim-dbee',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    lazy = true,
    ft = { 'sql' },
    config = function()
        require('dbee').setup({
            default_connection = 'local',
            result = {
                focus_result = false,
            },
            editor = {
                mappings = {
                    { key = '<leader>rq', mode = 'v', action = 'run_selection' },
                    { key = 'BB', mode = 'n', action = 'run_file' },
                    { key = '<CR>', mode = 'n', action = 'run_under_cursor' },
                    {
                        key = '<leader>sl',
                        mode = '',
                        action = function()
                            require('dbee').api.core.set_current_connection('local')
                        end,
                    },
                    {
                        key = '<leader>slt',
                        mode = '',
                        action = function()
                            require('dbee').api.core.set_current_connection('local_test')
                        end,
                    },
                    {
                        key = '<leader>ss',
                        mode = '',
                        action = function()
                            require('dbee').api.core.set_current_connection('staging')
                        end,
                    },
                },
            },
        })
    end,
}
