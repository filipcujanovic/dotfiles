local function get_dir_ascii()
    local ok, result =
        pcall(vim.fn.systemlist, string.format('figlet -w 200 -d ~/.config/figlet/fonts -f "ANSI Shadow" %s', vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')))
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
                    {
                        action = 'SessionRestore',
                        desc = ' Restore Session',
                        icon = '󰦛',
                        key = 'r',
                    },
                    { action = 'Lazy update', desc = ' Lazy Update', icon = '󰚰', key = 'u' },
                    { action = 'Lazy', desc = ' Lazy', icon = '', key = 'l' },
                    { action = 'FzfLua files', desc = ' Files', icon = '󰈞', key = 'f' },
                    { action = 'lua MiniFiles.open()', desc = ' Browse Files', icon = '', key = 'b' },
                    {
                        action = function()
                            vim.api.nvim_input('<cmd>qa<cr>')
                        end,
                        desc = ' Quit',
                        icon = '󰈆',
                        key = 'q',
                    },
                },
                footer = {},
            },
        })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
