return {
    'ntpeters/vim-better-whitespace',
    config = function()
        vim.g.better_whitespace_filetypes_blacklist = { 'dashboard' }
        vim.g.better_whitespace_guicolor = '#d65d0e'
    end,
}
