vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
local treesitter = require('nvim-treesitter')
local parsers = {
    'bash',
    'cpp',
    'devicetree',
    'git_config',
    'gitignore',
    'graphql',
    'html',
    'http',
    'kulala_http',
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
    'toml',
    'tsx',
    'twig',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'tmux',
}

treesitter.setup()
vim.api.nvim_create_autocmd('User', {
    pattern = 'TSUpdate',
    callback = function()
        require('nvim-treesitter.parsers').tmux = {
            install_info = {
                url = 'https://github.com/Freed-Wu/tree-sitter-tmux',
                queries = 'queries/',
            },
            tier = 2,
        }

        require('nvim-treesitter.parsers').kulala_http = {
            install_info = {
                url = 'https://github.com/dont-be-evil-company/tree-sitter-kulala-http',
                queries = 'queries/kulala_http',
            },
            tier = 2,
        }
    end,
})
treesitter.install(parsers)
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
            vim.treesitter.start(args.buf)
        end
    end,
})
