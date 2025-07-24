return {
    'echasnovski/mini.notify',
    version = '*',
    config = function()
        local mini_notify = require('mini.notify')
        mini_notify.setup({
            window = {
                winblend = 0,
            },
        })
        vim.notify = mini_notify.make_notify()
    end,
}
