vim.api.nvim_create_autocmd('InsertEnter', {
    once = true,
    callback = function()
        vim.pack.add({ 'https://github.com/nvim-mini/mini.surround' })
        require('mini.surround').setup({
            n_lines = 40,
        })
    end,
})
