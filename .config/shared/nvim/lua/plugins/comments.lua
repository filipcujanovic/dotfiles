return {
    'numToStr/Comment.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
        require('Comment').setup({
            padding = false,
            ignore = '^$',
        })
    end,
}
