return {
    'dont-be-evil-company/kulala.nvim',
    lazy = true,
    branch = 'main',
    ft = { 'http', 'rest' },
    opts = {
        debug = true,
        default_env = 'dev',
        global_keymaps = false,
        environment_scope = 'g',
        show_request_summary = false,
        ui = {
            display_mode = 'split',
            --split_direction = 'below',
            icons = {
                lualine = '',
            },
            win_opts = {
                wo = { number = true, relativenumber = true },
            },
            max_response_size = 1000000,
        },
    },
}
