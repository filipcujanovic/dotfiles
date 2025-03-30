return {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
        mode = 'cursor',
        max_lines = 1,
        enable = false,
    },
    keys = {
        {
            '<leader>tc',
            function()
                local tsc = require('treesitter-context')
                tsc.toggle()
            end,
            desc = 'Toggle Treesitter Context',
        },
    },
}
