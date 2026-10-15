vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.icons' })
require('mini.icons').setup()
require('mini.files').setup({
    mappings = {
        go_in_plus = '<CR>',
    },
})
