local function get_dir_ascii()
    local _, result = pcall(
        vim.fn.systemlist,
        string.format('figlet -w 200 -d ~/projects/dotfiles/.config/shared/figlet/fonts/ -f "ANSI Shadow" %s', vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t'))
    )
    table.insert(result, 1, '')
    table.insert(result, '')
    return result
end

return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup({
            theme = 'doom',
            config = {
                header = get_dir_ascii(),
                center = {
                    { action = 'Lazy check', desc = 'lazy check', icon = '', key = 'c' },
                    { action = 'Lazy', desc = 'lazy', icon = '', key = 'l' },
                    { action = 'lua vim.cmd(\'q\')', desc = 'quit', icon = '', key = 'q' },
                },
                footer = {},
            },
        })
    end,
}
