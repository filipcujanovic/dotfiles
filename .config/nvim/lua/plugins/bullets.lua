local fts = { 'markdown', 'text' }
return {
    'bullets-vim/bullets.vim',
    event = 'VeryLazy',
    lazy = true,
    ft = fts,
    config = function()
        -- Disable deleting the last empty bullet when pressing <cr> or 'o'
        -- default = 1
        vim.g.bullets_delete_last_bullet_if_empty = 0
        vim.g.bullets_enabled_file_types = fts
    end,
}
