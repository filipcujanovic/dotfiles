return {
    'nvim-mini/mini.surround',
    version = '*',
    event = 'InsertEnter',
    config = function()
        require('mini.surround').setup({})
    end,
}
