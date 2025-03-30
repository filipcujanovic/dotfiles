return {
    'tpope/vim-fugitive',
    event = 'CmdlineEnter',
    cmd = 'Git',
    keys = {
        {
            '<leader>gb',
            '<cmd>:Git blame<CR>',
        },
    },
}
