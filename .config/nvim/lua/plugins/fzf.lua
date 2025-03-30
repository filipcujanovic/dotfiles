return {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- calling `setup` is optional for customization
        local actions = require('fzf-lua.actions')
        require('fzf-lua').setup({
            'max-perf',
            keymap = {
                fzf = {
                    ['ctrl-q'] = 'select-all+accept',
                },
            },
            files = {
                cwd_prompt = false,
            },
            file_ignore_patterns = {
                'node_modules',
                --'vendor',
                '^adminrebuild',
                -- '^admin/',
                'v/1.*',
                'v/0.*',
                --'^.git/',
                -- '.git*',
            },
            defaults = {
                git_icons = false,
                file_icons = false,
                color_icons = false,
                actions = {
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-s'] = false,
                },
            },
            grep = {
                hidden = true,
            },
            buffers = {
                actions = {
                    ['ctrl-d'] = {
                        fn = function(selected)
                            local bufnr = tonumber(selected[1]:match('%d+'))
                            vim.api.nvim_buf_delete(bufnr, { force = true })
                        end,
                        reload = true,
                    },
                },
            },
        })
        vim.keymap.set('n', '<leader>k', require('fzf-lua').keymaps, { desc = '[ ] Find keymaps' })
        vim.keymap.set('n', '<leader><space>', require('fzf-lua').buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>?', require('fzf-lua').oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>gf', require('fzf-lua').git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>sf', require('fzf-lua').files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', require('fzf-lua').helptags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('fzf-lua').grep_cword, { desc = '[S]earch current [W]ord' })
        --vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', require('fzf-lua').diagnostics_document, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', require('fzf-lua').resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep_glob, { desc = '[S]earch [L]ive' })
        vim.keymap.set('n', '<leader>/', function()
            require('fzf-lua').grep_curbuf({ previewer = false })
        end, { desc = '[/] Fuzzily search in current buffer' })
    end,
}
