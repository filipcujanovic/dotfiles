-- clear jump list on start
vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
        vim.schedule(function()
            vim.cmd('clearjumps')
        end)
    end,
})

-- auto create git commit and push for notes dir and update icloud notes
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

-- highlight what is yanked
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- lsp keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', function()
            require('fzf-lua').lsp_definitions({ jump1 = true })
        end, '[G]oto [D]efinition')
        nmap('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
        nmap('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('fzf-lua').lsp_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        --nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        --nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        --nmap('<leader>wl', function()
        --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, '[W]orkspace [L]ist Folders')

        vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end,
})

-- remove padding from comment strings
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        local previous_comment_string = vim.opt_local.commentstring:get()
        if previous_comment_string and previous_comment_string:match('%%s') then
            vim.opt_local.commentstring = previous_comment_string:gsub('%s*%%s', '%%s')
        end
    end,
})
