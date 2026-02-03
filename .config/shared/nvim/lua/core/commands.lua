vim.api.nvim_create_user_command('ParseJson', '%!jq -r | jq .', { desc = 'parse json' })
vim.api.nvim_create_user_command('ParseSelectedJson', '\'<,\'>!jq .', { desc = 'parse selected json' })
vim.api.nvim_create_user_command('SortJson', '%!jq -S', { desc = 'sort json' })
vim.api.nvim_create_user_command('EncodeJson', '%!jq \'.\'', { desc = 'encode json' })
vim.api.nvim_create_user_command('DecodeJson', '%s/\\"/"/g', { desc = 'decode json' })
vim.api.nvim_create_user_command('CopyRelPath', 'call setreg(\'+\', expand(\'%\'))', { desc = 'copy current buffer path' })
vim.api.nvim_create_user_command('RmJsonData', '%s/\\\\"/"/g', { desc = 'remove extra data from json' })
vim.api.nvim_create_user_command('DecodeJson', '%!jq -sR .', { desc = 'decode json string' })
vim.api.nvim_create_user_command('ConvertToJson', '%!jq -sR .', { desc = 'convert string to json' })
vim.api.nvim_create_user_command('FindConflict', '/<<<<<<<', { desc = 'find conflict' })

local complete_client = function(arg)
    return vim.iter(vim.lsp.get_clients())
        :map(function(client)
            return client.name
        end)
        :filter(function(name)
            return name:sub(1, #arg) == arg
        end)
        :totable()
end

vim.api.nvim_create_user_command('LspRestart', function(info)
    local client_names = info.fargs

    -- Default to restarting all active servers
    if #client_names == 0 then
        client_names = vim.iter(vim.lsp.get_clients())
            :map(function(client)
                return client.name
            end)
            :totable()
    end

    for name in vim.iter(client_names) do
        if vim.lsp.config[name] == nil then
            vim.notify(('Invalid server name \'%s\''):format(name))
        else
            vim.lsp.enable(name, false)
            if info.bang then
                vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
                    client:stop(true)
                end)
            end
        end
    end

    local timer = assert(vim.uv.new_timer())
    timer:start(500, 0, function()
        for name in vim.iter(client_names) do
            vim.schedule_wrap(vim.lsp.enable)(name)
        end
    end)
end, {
    desc = 'Restart the given client',
    nargs = '?',
    bang = true,
    complete = complete_client,
})
