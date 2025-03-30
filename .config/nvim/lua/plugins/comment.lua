return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
            padding = false,
            ignore = '^$',
        })
    end,
}
