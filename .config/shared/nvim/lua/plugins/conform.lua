return {
    'stevearc/conform.nvim',
    config = function()
        local conform = require('conform')
        conform.formatters.shfmt = {
            append_args = { '-i', '4' },
        }
        conform.formatters.jq = {
            append_args = { '--indent', '2' },
        }
        conform.formatters.sql_formatter = {
            append_args = { '--config', vim.fn.expand('~/projects/dotfiles/.config/shared/nvim/formatters/sql-formatter/config.json') },
        }
        conform.setup({
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { 'stylua' },
                xml = { 'xmllint' },
                rust = { 'rustfmt' },
                json = { 'jq' },
                sh = { 'shfmt' },
                sql = { 'sql_formatter' },
                ['*'] = { 'trim_whitespace' },
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
