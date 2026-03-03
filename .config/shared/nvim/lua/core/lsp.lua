vim.lsp.config('*', {
    settings = {
        telemetry = {
            enabled = false,
        },
    },
})

vim.lsp.enable({
    'harper_ls',
    'html',
    'intelephense',
    'lua_ls',
    --'marksman',
    'markdown_oxide',
    'pyright',
    'sqls',
    'ts_ls',
})
