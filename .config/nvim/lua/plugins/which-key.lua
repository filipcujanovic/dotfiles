return {
    'folke/which-key.nvim',
    --enabled = false,
    config = function()
        local wk = require('which-key')
        wk.add({
            { '<leader>c', desc = '[C]ode' },
            { '<leader>d', desc = '[D]ocument' },
            { '<leader>g', desc = '[G]it' },
            { '<leader>h', desc = 'More git' },
            { '<leader>r', desc = '[R]ename' },
            { '<leader>s', desc = '[S]earch' },
            { '<leader>w', desc = '[W]orkspace' },
        })
        wk.setup({
            delay = 1500,
        })
    end,
}
