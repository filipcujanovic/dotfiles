vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'http', 'rest' },
    once = true,
    callback = function()
        vim.pack.add({ 'https://github.com/dont-be-evil-company/kulala.nvim' })
        require('kulala').setup({
            treesitter = {
                enable = false,
            },
            debug = true,
            default_env = 'dev',
            global_keymaps = false,
            environment_scope = 'g',
            show_request_summary = false,
            ui = {
                display_mode = 'split',
                --split_direction = 'below',
                icons = {
                    lualine = '',
                },
                win_opts = {
                    wo = { number = true, relativenumber = true },
                },
                max_response_size = 1000000,
            },
        })
        vim.keymap.set('n', '<leader>rr', function()
            require('kulala').run()
        end, { desc = 'run request' })

        vim.keymap.set('n', '<leader>re', function()
            require('kulala').set_selected_env()
        end, { desc = 'select env' })
    end,
})
