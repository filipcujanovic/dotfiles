return {
    'stevearc/conform.nvim',
    config = function()
        local conform = require('conform')
        conform.formatters = {
            shfmt = {
                append_args = {
                    '-i',
                    '4',
                },
            },
            jq = {
                append_args = {
                    '--indent',
                    '2',
                },
            },
            sql_formatter = {
                append_args = {
                    '--config',
                    vim.fn.expand('~/projects/dotfiles/.config/shared/nvim/formatters/sql-formatter/config.json'),
                },
            },
            --black = {
            --    timeout_ms = 10000,
            --},
        }
        conform.setup({
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                json = { 'jq' },
                lua = { 'stylua' },
                --python = { 'black' },
                rust = { 'rustfmt' },
                sh = { 'shfmt' },
                sql = { 'sql_formatter' },
                xml = { 'xmllint' },
                ['*'] = { 'trim_whitespace', 'trim_newlines' },
            },
        })
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*',
            callback = function(args)
                require('conform').format({ bufnr = args.buf })
            end,
        })
    end,
}
