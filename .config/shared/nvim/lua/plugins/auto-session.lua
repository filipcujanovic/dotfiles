return {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
        auto_restore = true,
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        auto_delete_empty_sessions = false,
        bypass_save_filetypes = { 'dashboard' },
    },
}
