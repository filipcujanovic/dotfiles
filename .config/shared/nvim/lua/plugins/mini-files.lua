return {
    'nvim-mini/mini.files',
    version = '*',
    lazy = true,
    dependencies = {
        {
            'nvim-mini/mini.icons',
            version = '*',
        },
    },
    config = function()
        require('mini.icons').setup()
        require('mini.files').setup({
            mappings = {
                go_in_plus = '<CR>',
            },
        })
    end,
}
