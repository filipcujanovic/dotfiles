return {
    'alexghergh/nvim-tmux-navigation',
    config = function()
        require('nvim-tmux-navigation').setup({
            disable_when_zoomed = true,
            keybindings = {
                left = '<C-s>h',
                down = '<C-s>j',
                up = '<C-s>k',
                right = '<C-s>l',
            },
        })
    end,
}
