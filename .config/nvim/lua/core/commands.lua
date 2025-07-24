vim.api.nvim_create_user_command('ParseJson', '%!jq .', { desc = 'parse json' })
vim.api.nvim_create_user_command('ParseSelectedJson', '\'<,\'>!jq .', { desc = 'parse selected json' })
vim.api.nvim_create_user_command('SortJson', '%!jq -S', { desc = 'sort json' })
vim.api.nvim_create_user_command('EncodeJson', '%!jq \'.\'', { desc = 'encode json' })
vim.api.nvim_create_user_command('DecodeJson', '%s/\\"/"/g', { desc = 'decode json' })
vim.api.nvim_create_user_command('CopyRelPath', 'call setreg(\'+\', expand(\'%\'))', { desc = 'copy current buffer path' })
vim.api.nvim_create_user_command('RmJsonData', '%s/\\\\"/"/g', { desc = 'remove extra data from json' })
vim.api.nvim_create_user_command('ConvertToJson', '%!jq -sR .', { desc = 'convert string to json' })
vim.api.nvim_create_user_command('FindConflict', '/<<<<<<<', { desc = 'find conflict' })
vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
        vim.schedule(function()
            vim.cmd('clearjumps')
        end)
    end,
})
