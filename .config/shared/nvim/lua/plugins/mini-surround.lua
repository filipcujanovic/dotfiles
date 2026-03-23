return {
    'nvim-mini/mini.surround',
    version = '*',
    event = 'InsertEnter',
    config = function()
        require('mini.surround').setup({
            n_lines = 40,
        })
    end,
}
