return {
    'ibhagwan/fzf-lua',
    config = function()
        local fzf = require('fzf-lua')
        local actions = fzf.actions
        fzf.setup({
            'max-perf',
            winopts = {
                preview = {
                    layout = 'vertical',
                },
            },
            keymap = {
                fzf = {
                    ['ctrl-q'] = 'select-all+accept',
                },
            },
            files = {
                cwd_prompt = false,
            },
            file_ignore_patterns = {
                '.obsidian/',
                --'node_modules',
                --'vendor',
                '^adminrebuild',
                -- '^admin/',
                'v/1.*',
                'v/0.*',
                --'^.git/',
                -- '.git*',
            },
            defaults = {
                actions = {
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-s'] = false,
                },
            },
            grep = {
                hidden = true,
                rg_glob = true,
            },
            buffers = {
                actions = {
                    ['ctrl-d'] = {
                        fn = function(selected)
                            local bufnr = tonumber(selected[1]:match('%d+'))
                            bufnr = bufnr == nil and 0 or bufnr + 0
                            vim.api.nvim_buf_delete(bufnr, { force = true })
                        end,
                        reload = true,
                    },
                },
            },
        })
        vim.keymap.set('n', '<leader>k', fzf.keymaps, { desc = 'Find [K]eymaps' })
        vim.keymap.set('n', '<leader><space>', function()
            fzf.buffers({ previewer = false })
        end, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>?', fzf.oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>gf', fzf.git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>sf', function()
            fzf.files({ previewer = false })
        end, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>ss', fzf.spell_suggest, { desc = '[S]ell [S]suggest' })
        vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>/', function()
            fzf.grep_curbuf({ previewer = false })
        end, { desc = '[/] Fuzzily search in current buffer' })
    end,
}
