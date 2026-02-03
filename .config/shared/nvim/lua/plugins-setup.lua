vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
--vim.opt.rtp:prepend('/run/current-system/sw/bin/')

require('lazy').setup({
    spec = {
        import = 'plugins',
    },
    change_detection = {
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'netrwPlugin',
                'gzip',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    ui = {
        custom_keys = {
            ['<localleader>r'] = {
                function(_)
                    local plugins = require('lazy.core.config').plugins
                    local file_content = {
                        [[
# nvim

<img src="/assets/images/dotfiles-smaller.png" width="49%" height="50%"> <img src="/assets/images/code.png" width="49%" height="50%"> <img src="/assets/images/file-search.png" width="49%" height="50%"> <img src="/assets/images/keymaps.png" width="49%" height="50%">
]],
                        '# plugin manager',
                        '',
                        '- [lazy.nvim](https://github.com/folke/lazy.nvim)',
                        '',
                        '# plugins',
                        '',
                    }
                    local plugins_md = {}
                    for plugin, spec in pairs(plugins) do
                        if spec.url then
                            table.insert(plugins_md, ('- [%s](%s)'):format(plugin, spec.url:gsub('%.git$', '')))
                        end
                    end
                    table.sort(plugins_md, function(a, b)
                        return a:lower() < b:lower()
                    end)

                    for _, p in ipairs(plugins_md) do
                        table.insert(file_content, p)
                    end

                    local file, err = io.open(vim.fn.stdpath('config') .. '/README.md', 'w')
                    if not file then
                        vim.notify('didn\'t work!', vim.log.levels.ERROR, {})
                        error(err)
                    end
                    file:write(table.concat(file_content, '\n'))
                    file:close()
                    vim.notify('README.md succesfully generated', vim.log.levels.INFO, {})
                end,
                desc = 'Generate README.md file',
            },
        },
    },
}, {})
