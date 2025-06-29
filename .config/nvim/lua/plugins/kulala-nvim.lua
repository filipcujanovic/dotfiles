return {
    'mistweaverco/kulala.nvim',
    lazy = true,
    event = 'VeryLazy',
    branch = 'develop',
    ft = { 'http', 'rest' },
    opts = {
        debug = true,
        global_keymaps = false,
        environment_scope = 'g',
        show_request_summary = false,
        ui = {
            display_mode = 'split',
            icons = {
                lualine = '',
            },
            win_opts = {
                wo = { number = true, relativenumber = true },
            },
        },
    },
}
