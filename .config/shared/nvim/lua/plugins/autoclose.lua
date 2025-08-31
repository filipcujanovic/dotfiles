return {
    'm4xshen/autoclose.nvim',
    lazy = true,
    event = 'VeryLazy',
    version = '*',
    config = function()
        require('autoclose').setup({})
    end,
}
