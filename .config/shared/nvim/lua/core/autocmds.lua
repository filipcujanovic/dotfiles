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
--vim.api.nvim_create_autocmd('BufWritePost', {
--    once = true,
--    callback = function()
--        vim.fn.jobstart('git rev-parse --show-toplevel', {
--            --on_exit = some_function,
--            --on_stderr = some_third_function,
--            on_stdout = function(_, data, _)
--                local root_dir_table = vim.split(data[1], '/')
--                local root_dir = root_dir_table[#root_dir_table]
--                local os_name = vim.loop.os_uname().sysname == 'Darwin' and 'macos' or 'linux'
--                local icloud_notes_dir = '/Users/cujanovic/Library/Mobile Documents/iCloud~md~obsidian/Documents/the-never-ending-hole-backup/'
--                if root_dir == 'the-never-ending-hole' then
--                    vim.fn.jobstart(
--                        string.format('git add . && git commit -m "vault backup (%s): %s" && git push origin main', os_name, os.date('%Y-%m-%d %X'))
--                    )
--                    vim.fn.jobstart(string.format('cp -R * "%s"', icloud_notes_dir))
--                end
--            end,
--        })
--    end,
--})

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
        nmap('<leader>lf', vim.lsp.buf.format, 'Lsp Format')

        vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end,
})

-- remove padding from comment strings
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        if vim.tbl_contains({ 'php', 'dts' }, vim.bo.filetype) then
            vim.opt_local.commentstring = '//%s'
        else
            local previous_comment_string = vim.opt_local.commentstring:get()
            if previous_comment_string and previous_comment_string:match('%%s') then
                vim.opt_local.commentstring = previous_comment_string:gsub('%s*%%s', '%%s')
            end
        end
    end,
})

-- I am using tab and leadmultispace in listchars to display the indent line. The chars for tab and
-- leadmultispace should be updated based on whether the indentation has been changed.
-- * If using space as indentation: set tab to a special character for denotation and leadmultispace
-- to the indent line character followed by multiple spaces whose amounts depends on the number of
-- spaces to use in each step of indent.
-- * If using tab as indentation: set leadmultispace to a special character for denotation and tab
-- to the indent line character.
local function update(is_local)
    local listchars_update = function(items)
        local listchars = vim.api.nvim_get_option_value('listchars', {})
        for item, val in pairs(items) do
            if listchars:match(item) then
                listchars = listchars:gsub('(' .. item .. ':)[^,]*', '%1' .. val)
            else
                listchars = listchars .. ',' .. item .. ':' .. val
            end
        end
        return listchars
    end
    local new_listchars = ''
    if vim.api.nvim_get_option_value('expandtab', {}) then
        local spaces = vim.api.nvim_get_option_value('shiftwidth', {})
        -- When shiftwidth is 0, vim will use tabstop value
        if spaces == 0 then
            spaces = vim.api.nvim_get_option_value('tabstop', {})
        end
        new_listchars = listchars_update({
            tab = '› ',
            leadmultispace = vim.g.indentline_char .. string.rep(' ', spaces - 1),
        })
    else
        new_listchars = listchars_update({
            tab = vim.g.indentline_char .. ' ',
            leadmultispace = '␣',
        })
    end
    local opts = {}
    if is_local then
        opts.scope = 'local'
    end
    vim.api.nvim_set_option_value('listchars', new_listchars, opts)
end
vim.api.nvim_create_augroup('indent_line', { clear = true })
vim.api.nvim_create_autocmd({ 'OptionSet' }, {
    group = 'indent_line',
    pattern = { 'shiftwidth', 'expandtab', 'tabstop' },
    callback = function()
        update(vim.v.option_type == 'local')
    end,
})
-- OptionSet is not triggered on startup
-- This may be not needed. The listchars has been set properly in options.vim and it will be sourced
-- on startup.
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    group = 'indent_line',
    callback = function()
        update(false)
    end,
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
    command = 'wincmd =',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('no_auto_comment', {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        local function task_newline()
            local line = vim.api.nvim_get_current_line()
            local result = ''

            if line:match('%-%s%[%s?([ x])]%s%-%s.+') then
                result = '- [ ] - '
            end

            return result
        end

        local function mark_item_as_completed()
            local line = vim.api.nvim_get_current_line()
            local new_line = line:gsub('%-%s%[%s?([ x])]%s%-', function(mark)
                return mark == ' ' and '- [x] -' or '- [ ] -'
            end)
            vim.api.nvim_set_current_line(new_line)
        end

        vim.keymap.set('v', '<leader>ch', function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', true)

            local start_line = vim.fn.line('\'<')
            local end_line = vim.fn.line('\'>')

            for lnum = start_line, end_line do
                local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
                local new_line = line:gsub('%- %[%s?([ x])%s?%] %-', function(mark)
                    return mark == ' ' and '- [x] -' or '- [ ] -'
                end)
                vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, { new_line })
            end
        end, { noremap = true, silent = true })

        vim.keymap.set('i', '<CR>', function()
            return '<CR>' .. task_newline()
        end, {
            expr = true,
            buffer = true,
        })

        vim.keymap.set('n', 'o', function()
            return 'o' .. task_newline()
        end, {
            expr = true,
            buffer = true,
        })
        vim.keymap.set('n', '<leader>ch', mark_item_as_completed)

        vim.api.nvim_create_autocmd('BufWritePost', {
            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()
                local buffer_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t:r')

                local first = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]

                local header = {
                    '---',
                    string.format('id: %s', buffer_name),
                    'aliases: []',
                    'tags: []',
                    '---',
                }

                if first ~= '---' then
                    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
                end
            end,
        })
    end,
})
