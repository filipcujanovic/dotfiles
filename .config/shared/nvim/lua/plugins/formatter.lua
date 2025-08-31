return {
    'mhartington/formatter.nvim',
    event = { 'BufWrite' },
    config = function()
        local util = require('formatter.util')
        require('formatter').setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                json = {
                    function()
                        return {
                            exe = 'jq',
                            args = {
                                --'--tab',
                                '--indent 2',
                                '.',
                            },
                            stdin = true,
                        }
                    end,
                },
                rust = {
                    require('formatter.filetypes.rust').rustfmt,
                },
                lua = {
                    require('formatter.filetypes.lua').stylua,
                    function()
                        if util.get_current_buffer_file_name() == 'special.lua' then
                            return nil
                        end
                        return {
                            exe = 'stylua',
                            args = {
                                '--search-parent-directories',
                                '--stdin-filepath',
                                util.escape_path(util.get_current_buffer_file_path()),
                                '--',
                                '-',
                            },
                            stdin = true,
                        }
                    end,
                },
                sql = {
                    function()
                        return {
                            exe = 'sql-formatter',
                            args = {
                                '--config ~/dotfiles/.config/nvim/formatters/sql-formatter/config.json',
                            },
                            stdin = true,
                        }
                    end,
                },
                ['*'] = {
                    require('formatter.filetypes.any').remove_trailing_whitespace,
                },
            },
        })
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        augroup('__formatter__', { clear = true })
        autocmd('BufWritePost', {
            group = '__formatter__',
            command = ':FormatWrite',
        })
    end,
}
