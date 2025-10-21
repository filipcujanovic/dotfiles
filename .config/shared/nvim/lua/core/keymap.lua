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

local function minifiles_open_current()
    if vim.fn.filereadable(vim.fn.bufname('%')) > 0 then
        require('mini.files').open(vim.api.nvim_buf_get_name(0), false)
    else
        require('mini.files').open()
    end
end
--vim.keymap.set('n', '<leader>b', minifiles_open_current, { desc = 'open mini files' })
--vim.keymap.set('n', '<leader>b', ':Lexplore %:p:h<CR>', { desc = 'open netrw' })
vim.keymap.set('n', '<leader>b', function()
    local is_netrw_open = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_get_option_value('filetype', { buf = buf }) == 'netrw' then
            is_netrw_open = true
        end
    end

    if is_netrw_open then
        vim.cmd('Lexplore')
    else
        vim.cmd('Lexplore %:p:h')
    end
end, { desc = 'open netrw' })

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
    --local commit = vim.fn.system(string.format('git log -1 --pretty=format:"%%H" -L %s,%s:%s | head -n1 | awk "{print $1}"', line_num, line_num, file_path))
    local commit = vim.fn.getreg('+')

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
    if require('obsidian').util.cursor_link() then
        return '<cmd>Obsidian follow_link<cr>'
    else
        return 'gf'
    end
end, {
    expr = true,
    desc = 'go to file',
})
