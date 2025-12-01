vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-f>', '<C-a>', { desc = 'Increment number' })
vim.keymap.set('n', '<C-g>', '<C-x>', { desc = 'Decrement number' })
vim.keymap.set('n', '<C-q>', ':set hlsearch!<cr>', { desc = 'toggle search highlight' })
vim.keymap.set('n', '<leader>lw', ':set wrap!<cr>', { desc = 'toggle line wrap' })
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>', { desc = 'new tab' })
vim.keymap.set('n', '<leader>wa', vim.cmd.wa, { desc = 'write all' })
vim.keymap.set('n', '<leader>x', ':quit!<CR>', { desc = 'force quit' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'quit' })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'write' })
vim.keymap.set('n', '<leader>n', ':tabn<CR>', { desc = 'tab next' })
vim.keymap.set('n', '<leader>p', ':tabp<CR>', { desc = 'tab previous' })

vim.keymap.set('n', 'k', 'v:count == 0 ? \'gk\' : \'k\'', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? \'gj\' : \'j\'', { expr = true, silent = true })

vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })

--vim.keymap.set('n', '<leader>b', function()
--    local is_netrw_open = false
--    for _, win in ipairs(vim.api.nvim_list_wins()) do
--        local buf = vim.api.nvim_win_get_buf(win)
--        if vim.api.nvim_get_option_value('filetype', { buf = buf }) == 'netrw' then
--            is_netrw_open = true
--        end
--    end
--
--    if is_netrw_open then
--        vim.cmd('Lexplore')
--    else
--        vim.cmd('Lexplore %:p:h')
--    end
--end, { desc = 'open netrw' })

local open_file_from_yazi = function(yazi_current_file)
    if vim.fn.filereadable(yazi_current_file) == 1 then
        local selection = vim.fn.readfile(yazi_current_file)
        vim.fn.delete(yazi_current_file)
        if selection and #selection > 0 and selection[1] ~= '' then
            local file_to_open = vim.fn.fnameescape(selection[1])
            vim.cmd(string.format('edit %s', file_to_open))
        end
    end
end

local yazi_in_tmux = function()
    local yazi_current_file = '/tmp/current-yazi-file'
    local current_file_path = vim.fn.expand('%')
    vim.fn.delete(yazi_current_file)
    vim.fn.system(
        string.format(
            'tmux display-popup -w 90%% -h 90%% -E "tmux new-session -d -s yazi \\"yazi --chooser-file=%s %s\\"; tmux set-option -t yazi detach-on-destroy on; tmux a -t yazi"',
            yazi_current_file,
            current_file_path
        )
    )
    open_file_from_yazi(yazi_current_file)
end

local yazi_in_nvim_terminal = function()
    local yazi_current_file = '/tmp/current-yazi-file'
    local current_file_path = vim.fn.expand('%')
    vim.fn.delete(yazi_current_file)

    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    vim.fn.jobstart(string.format('yazi --chooser-file=%s %s', yazi_current_file, current_file_path), {
        term = true,
        on_exit = function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end

            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end

            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            open_file_from_yazi(yazi_current_file)
        end,
    })

    vim.cmd('startinsert')
end

vim.keymap.set('n', '<leader>b', function()
    yazi_in_nvim_terminal()
end, { desc = 'Open yazi in floating window' })

vim.keymap.set('n', '<leader>gch', ':Ghdiffsplit!<cr>', { desc = 'git conflict horizontal' })
vim.keymap.set('n', '<leader>gcv', ':Gvdiffsplit!<cr>', { desc = 'git conflict vertical' })

vim.keymap.set('n', '<leader>rmj', ':RmJsonData<cr>', { desc = 'remove extra \\ from data' })
vim.keymap.set('n', '<leader>pj', ':ParseJson<cr>', { desc = 'parse json' })
vim.keymap.set('n', '<leader>psj', ':ParseSelectedJson<cr>', { desc = 'parse selected json' })
vim.keymap.set('n', '<leader>sj', ':SortJson<cr>', { desc = 'sort json' })
vim.keymap.set('n', '<leader>cj', ':ConvertToJson<cr>', { desc = 'convert string to json string' })
vim.keymap.set('n', '<leader>crp', ':CopyRelPath<cr>', { desc = 'copy relative path of buffer' })
vim.keymap.set('n', '<leader>fc', ':FindConflict<cr>', { desc = 'find conflict' })
vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<cr>', { desc = 'markdown preview toggle' })
vim.keymap.set('n', '<leader>gt', function()
    local line_num = vim.fn.line('.')
    local file_path = vim.fn.expand('%:p')
    local commit = vim.fn.system(string.format('git blame -L %d,%d --porcelain -- %s | sed -n "1s/ .*//p"', line_num, line_num, file_path)):gsub('\n', '')
    if commit:match('^0+$') ~= nil or #commit ~= 40 then
        return
    end

    local origin = vim.fn.system('git config --get remote.origin.url')
    origin = origin:gsub('%s+$', '')
    origin = origin:gsub(':', '/'):gsub('git@', 'https://'):gsub('^ssh://', 'https://'):gsub('%.git$', '')
    local url = string.format('%s/commit/%s', origin, commit)
    vim.fn.system(string.format('open %s', url))
end, { desc = 'open git file in browser ' })

vim.keymap.set('n', '<leader>ot', ':ObsidianTags<cr>', { desc = 'open obsidian tags' })

vim.keymap.set('n', '<leader>rr', function()
    require('kulala').run()
end, { desc = 'run request' })

vim.keymap.set('n', '<leader>re', function()
    require('kulala').set_selected_env()
end, { desc = 'select env' })

vim.keymap.set('n', '<leader>lg', function()
    vim.fn.system('tmux display-popup -w 95% -h 90% -E -d ' .. vim.fn.shellescape(vim.fn.getcwd()) .. ' lazygit')
end, { desc = 'lazygit' })

vim.keymap.set('n', '<leader>vd', function()
    vim.fn.system('tmux display-popup -w 95% -h 90% -E -d ' .. vim.fn.shellescape(vim.fn.getcwd()) .. '-- visidata ' .. vim.fn.expand('%:p'))
end, { desc = 'visidata' })

vim.keymap.set('n', 'gf', function()
    local word = vim.fn.expand('<cWORD>')
    local match = word:match('https?://%w+%.%w+[%w%-%._@%%:%+~#%?&/=]*')
    if match ~= nil then
        vim.fn.system(string.format('open "%s"', match))
    else
        return 'gf'
    end
end, {
    expr = true,
    desc = 'go to file',
})
