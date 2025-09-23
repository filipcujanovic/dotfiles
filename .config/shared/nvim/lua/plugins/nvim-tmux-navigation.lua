return {
    'alexghergh/nvim-tmux-navigation',
    keys = {
        {
            '<C-s>h',
            '<Cmd>NvimTmuxNavigateLeft<cr>',
            desc = 'Navigate left',
        },
        {
            '<C-s>j',
            '<Cmd>NvimTmuxNavigateDown<cr>',
            desc = 'Navigate down',
        },
        {
            '<C-s>k',
            '<Cmd>NvimTmuxNavigateUp<cr>',
            desc = 'Navigate up',
        },
        {
            '<C-s>l',
            '<Cmd>NvimTmuxNavigateRight<cr>',
            desc = 'Navigate right',
        },
    },
    config = true,
}
