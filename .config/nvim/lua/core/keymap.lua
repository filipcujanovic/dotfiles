-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-f>', '<C-a>', { desc = 'Increment number' }) -- increment
vim.keymap.set('n', '<C-g>', '<C-x>', { desc = 'Decrement number' }) -- decrement
vim.keymap.set('n', '<C-q>', ':set hlsearch!<cr>', { desc = 'toggle search highlight' })
vim.keymap.set('n', '<leader>lw', ':set wrap!<cr>', { desc = 'toggle line wrap' })
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>', { desc = 'new tab' })
vim.keymap.set('n', '<leader>sa', vim.cmd.wa, { desc = 'save all' })
--vim.keymap.set('n', '<leader>x', function()
--    vim.cmd('qa!')
--end, { desc = 'quit without saving' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', 'v:count == 0 ? \'gk\' : \'k\'', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? \'gj\' : \'j\'', { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })

local function minifiles_open_current()
    if vim.fn.filereadable(vim.fn.bufname('%')) > 0 then
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    else
        MiniFiles.open()
    end
end
vim.keymap.set('n', '<leader>b', minifiles_open_current, { desc = 'open mini files' })

vim.keymap.set('n', '<leader>gch', ':Ghdiffsplit!<cr>', { desc = 'git conflict horizontal' })
vim.keymap.set('n', '<leader>gcv', ':Gvdiffsplit!<cr>', { desc = 'git conflict vertical' })

vim.keymap.set('n', '<leader>rmj', ':RmJsonData<cr>', { desc = 'remove extra \\ from data' })
vim.keymap.set('n', '<leader>pj', ':ParseJson<cr>', { desc = 'prettify json' })
vim.keymap.set('n', '<leader>sj', ':SortJson<cr>', { desc = 'sort json' })
vim.keymap.set('n', '<leader>cj', ':ConvertToJson<cr>', { desc = 'convert string to json string' })
vim.keymap.set('n', '<leader>crp', ':CopyRelPath<cr>', { desc = 'copy relative path of buffer' })
vim.keymap.set('n', '<leader>fc', ':FindConflict<cr>', { desc = 'find conflict' })
vim.keymap.set('n', '<leader>gt', function()
    local clip_content = vim.fn.getreg('+')
    vim.api.nvim_command(':GBrowse ' .. clip_content)
end, { desc = 'open git file in browser ' })

vim.keymap.set('n', '<leader>ot', ':ObsidianTags<cr>', { desc = 'open obsidian tags' })

vim.keymap.set('n', '<leader>rr', function()
    require('kulala').run()
end, { desc = 'run request' })

vim.keymap.set('n', '<leader>re', function()
    require('kulala').set_selected_env()
end, { desc = 'run request' })

vim.keymap.set('n', '<leader>lg', function()
    vim.fn.system('tmux display-popup -w 95% -h 90% -E -d ' .. vim.fn.shellescape(vim.fn.getcwd()) .. ' lazygit')
end, { desc = 'lazygit' })

vim.keymap.set('n', '<leader>vd', function()
    vim.fn.system('tmux display-popup -w 95% -h 90% -E -d ' .. vim.fn.shellescape(vim.fn.getcwd()) .. '-- visidata ' .. vim.fn.expand('%:p'))
end, { desc = 'visidata' })

vim.keymap.set('n', '<leader>pt', function()
    local cmd = 'zsh -ic "source ~/.zshrc && rununittests"'
    vim.fn.jobstart('osascript -e "display notification \\"Start\\" with title \\"Unit Tests\\""', { detach = true })
    vim.fn.jobstart(cmd, { pty = true })
end, { noremap = true, silent = true, desc = 'run unit tests' })
