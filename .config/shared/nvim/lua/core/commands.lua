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
vim.api.nvim_create_autocmd('BufWritePost', {
    once = true,
    callback = function()
        vim.fn.jobstart('git rev-parse --show-toplevel', {
            --on_exit = some_function,
            --on_stderr = some_third_function,
            on_stdout = function(_, data, _)
                local root_dir_table = vim.split(data[1], '/')
                local root_dir = root_dir_table[#root_dir_table]
                local os_name = vim.loop.os_uname().sysname == 'Darwin' and 'macos' or 'linux'
                local icloud_notes_dir = '/Users/cujanovic/Library/Mobile Documents/iCloud~md~obsidian/Documents/the-never-ending-hole-backup/'
                if root_dir == 'the-never-ending-hole' then
                    vim.fn.jobstart(
                        string.format('git add . && git commit -m "vault backup (%s): %s" && git push origin main', os_name, os.date('%Y-%m-%d %X'))
                    )
                    vim.fn.jobstart(string.format('cp -R * "%s"', icloud_notes_dir))
                end
            end,
        })
    end,
})
