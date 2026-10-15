vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-f>', '<C-a>', { desc = 'Increment number' })
vim.keymap.set('n', '<C-g>', '<C-x>', { desc = 'Decrement number' })
vim.keymap.set('n', '<C-q>', ':set hlsearch!<cr>', { desc = 'toggle search highlight' })
vim.keymap.set('n', '<leader>lw', ':set wrap!<cr>', { desc = 'toggle line wrap' })
vim.keymap.set('n', '<leader>ut', function()
    vim.cmd('packadd nvim.undotree')
    require('undotree').open()
end)
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>', { desc = 'new tab' })
vim.keymap.set('n', '<leader>wa', vim.cmd.wa, { desc = 'write all' })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'write' })
vim.keymap.set('n', '<leader>n', ':tabn<CR>', { desc = 'tab next' })
vim.keymap.set('n', '<leader>p', ':tabp<CR>', { desc = 'tab previous' })
vim.keymap.set('n', '<leader>x', function()
    if vim.bo.buftype == 'terminal' then
        vim.cmd('bd!')
    else
        vim.cmd('q!')
    end
end, { desc = 'force quit' })
vim.keymap.set('n', '<leader>q', function()
    vim.cmd('confirm q')
end, { desc = 'quit' })

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

--vim.keymap.set('n', '<leader>b', function()
--    require('../core/tools.yazi-file-explorer').open_file_explorer('yazi', true)
--end, { desc = 'open file explorer' })
--vim.keymap.set('n', '<leader>tr', function()
--    require('nvim-tree.api').tree.toggle({ focus = false })
--end, { desc = 'toggle nvim tree' })
local function minifiles_open_current()
    if vim.fn.filereadable(vim.fn.bufname('%')) > 0 then
        require('mini.files').open(vim.api.nvim_buf_get_name(0), false)
    else
        require('mini.files').open()
    end
end
vim.keymap.set('n', '<leader>b', minifiles_open_current, {})
vim.keymap.set('n', '<leader>gch', ':Ghdiffsplit!<cr>', { desc = 'git conflict horizontal' })
vim.keymap.set('n', '<leader>gcv', ':Gvdiffsplit!<cr>', { desc = 'git conflict vertical' })

vim.keymap.set('n', '<leader>rmj', ':RmJsonData<cr>', { desc = 'remove extra \\ from data' })
vim.keymap.set('n', '<leader>pj', ':ParseJson<cr>', { desc = 'parse json' })
vim.keymap.set('n', '<leader>psj', ':ParseSelectedJson<cr>', { desc = 'parse selected json' })
vim.keymap.set('n', '<leader>sj', ':SortJson<cr>', { desc = 'sort json' })
vim.keymap.set('n', '<leader>cj', ':ConvertToJson<cr>', { desc = 'convert string to json string' })
vim.keymap.set('n', '<leader>crp', ':CopyRelPath<cr>', { desc = 'copy relative path of buffer' })
vim.keymap.set('n', '<leader>fc', ':FindConflict<cr>', { desc = 'find conflict' })
--vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<cr>', { desc = 'markdown preview toggle' })
vim.keymap.set('n', '<leader>gt', function()
    local line_num = vim.fn.line('.')
    local file_path = vim.fn.expand('%:p')
    local commit = vim.fn.system(string.format('git blame -L %d,%d --porcelain -- %s | sed -n "1s/ .*//p"', line_num, line_num, file_path)):gsub('\n', '')
    print(vim.inspect(commit))
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

--vim.api.nvim_create_autocmd('FileType', {
--    pattern = 'http',
--    callback = function()
--    end,
--})

vim.keymap.set('n', '<leader>lg', function()
    --vim.fn.system('tmux display-popup -w 95% -h 90% -E tmux new-session -A -s float')
    vim.fn.system('tmux display-popup -w 95% -h 90% -E -d ' .. vim.fn.shellescape(vim.fn.getcwd()) .. ' lazygit')
end, { desc = 'lazygit' })

vim.keymap.set('n', '<leader>ld', function()
    vim.fn.system('tmux display-popup -w 95% -h 90% -E -d ' .. vim.fn.shellescape(vim.fn.getcwd()) .. ' lazydocker')
end, { desc = 'lazydocker' })

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

vim.keymap.set('n', '<leader>ur', function()
    local plugins = vim.pack.get()
    local file_content = {
        [[
# nvim

<img src="/assets/images/dotfiles-smaller.png" width="49%" height="50%"> <img src="/assets/images/code.png" width="49%" height="50%"> <img src="/assets/images/file-search.png" width="49%" height="50%"> <img src="/assets/images/keymaps.png" width="49%" height="50%">
]],
        '# plugins',
        '',
    }
    local custom_plugins_path = '/lua/plugins/custom-plugins/'
    local custom_plugins_local_path = string.format('%s%s', vim.fn.stdpath('config'), custom_plugins_path)
    local git_path = string.format('.config/shared/nvim%s', custom_plugins_path)
    local custom_plugins = {}
    for name, type in vim.fs.dir(custom_plugins_local_path) do
        if type == 'file' then
            table.insert(custom_plugins, { name = name, src = string.format('%s%s', git_path, name) })
        end
    end
    local plugins_md = {}
    for _, plugin in pairs(plugins) do
        if plugin.spec.src then
            table.insert(plugins_md, ('- [%s](%s)'):format(plugin.spec.name, plugin.spec.src:gsub('%.git$', '')))
        end
    end
    table.sort(plugins_md, function(a, b)
        return a:lower() < b:lower()
    end)

    for _, p in ipairs(plugins_md) do
        table.insert(file_content, p)
    end

    table.insert(file_content, '\n# custom plugins\n')
    for _, custom_plugin in pairs(custom_plugins) do
        table.insert(file_content, ('- [%s](%s)'):format(custom_plugin.name, custom_plugin.src:gsub('%.git$', '')))
    end

    local file, err = io.open(vim.fn.stdpath('config') .. '/README.md', 'w')
    if not file then
        vim.notify('didn\'t work!', vim.log.levels.ERROR, {})
        error(err)
    end
    file:write(table.concat(file_content, '\n'))
    file:close()
    vim.notify('README.md succesfully generated', vim.log.levels.INFO, {})
end)
