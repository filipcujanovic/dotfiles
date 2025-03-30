-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-f>', '<C-a>', { desc = 'Increment number' }) -- increment
vim.keymap.set('n', '<C-g>', '<C-x>', { desc = 'Decrement number' }) -- decrement
vim.keymap.set('n', '<C-q>', ':set hlsearch!<cr>', { desc = 'toggle search highlight' })
vim.keymap.set('n', '<leader>lw', ':set wrap!<cr>', { desc = 'toggle line wrap' })
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>', { desc = 'new tab' })
vim.keymap.set('n', '<leader>sa', vim.cmd.wa, { desc = 'save all' })

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

-- Nvim tree
local function minifiles_open_current()
    if vim.fn.filereadable(vim.fn.bufname('%')) > 0 then
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    else
        MiniFiles.open()
    end
end
vim.keymap.set('n', '<leader>b', minifiles_open_current, {})

vim.keymap.set('n', '<leader>gch', ':Ghdiffsplit!<cr>')
vim.keymap.set('n', '<leader>gcv', ':Gvdiffsplit!<cr>')

local Terminal = require('toggleterm.terminal').Terminal

vim.keymap.set('n', '<leader>vd', function()
    local buffer = vim.fn.expand('%:p')
    local visidata = Terminal:new({
        cmd = 'visidata ' .. buffer,
        direction = 'float',
    })
    visidata:toggle()
end)

vim.keymap.set('n', '<leader>lg', function()
    local lazygit = Terminal:new({
        cmd = 'lazygit',
        direction = 'float',
    })
    lazygit:toggle()
end)

--custom commands
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
