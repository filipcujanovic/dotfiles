return {
    'echasnovski/mini.files',
    version = '*',
    lazy = true,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    config = function()
        require('mini.files').setup({
            mappings = {
                go_in_plus = '<CR>',
            },
        })
    end,
}
