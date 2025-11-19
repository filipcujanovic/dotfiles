return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        opts = {
            select = {
                enable = true,
                lookahead = true,
            },
            move = {
                enable = true,
                set_jumps = true,
            },
            swap = {
                enable = true,
            },
        },
        config = function()
            vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
                require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
                require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
            end)

            vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
                require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
            end)

            vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
                require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
                require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
            end)

            vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
                require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
                require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
            end)

            vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
                require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
                require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
            end)

            vim.keymap.set({ 'x', 'o' }, 'af', function()
                require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'if', function()
                require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'ac', function()
                require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'ic', function()
                require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'aa', function()
                require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects')
            end)
            vim.keymap.set({ 'x', 'o' }, 'ia', function()
                require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects')
            end)

            vim.keymap.set('n', '<leader>a', function()
                require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
            end)
            vim.keymap.set('n', '<leader>A', function()
                require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.outer')
            end)
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        opts = {},
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                'bash',
                'cpp',
                'devicetree',
                'git_config',
                'gitignore',
                'graphql',
                'html',
                'http',
                'javascript',
                'json',
                'lua',
                'markdown',
                'markdown_inline',
                'nix',
                'php',
                'php_only',
                'phpdoc',
                'python',
                'regex',
                'rust',
                'scss',
                'sql',
                'tmux',
                'toml',
                'tsx',
                'twig',
                'typescript',
                'vim',
                'vimdoc',
                'xml',
            },
            --incremental_selection = {
            --    enable = true,
            --    keymaps = {
            --        init_selection = '<c-space>',
            --        node_incremental = '<c-space>',
            --        scope_incremental = '<c-s>',
            --        node_decremental = '<M-space>',
            --    },
            --},
        },
        config = function(_, opts)
            --vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
            local treesitter = require('nvim-treesitter')
            treesitter.setup(opts)
            treesitter.install(opts.ensure_installed)
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
                        vim.treesitter.start(args.buf)
                    end
                end,
            })
        end,
    },
}
