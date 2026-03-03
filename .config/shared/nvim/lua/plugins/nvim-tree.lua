return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    config = function()
        require('nvim-tree').setup({
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
            },
            sort = {
                sorter = 'case_sensitive',
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
                git_ignored = false,
            },
            view = {
                number = true,
                relativenumber = true,
            },
        })
    end,
}
