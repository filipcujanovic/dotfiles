return {
    'saghen/blink.cmp',
    dependencies = {
        --'rafamadriz/friendly-snippets',
    },
    version = 'v1.*',
    opts = {
        completion = {
            accept = { auto_brackets = { enabled = true } },
            list = {
                selection = {
                    preselect = function(ctx)
                        return ctx.mode ~= 'cmdline'
                    end,
                    auto_insert = true,
                },
            },
            menu = {
                draw = {
                    columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
                },
            },
        },
        keymap = { preset = 'enter' },
        appearance = {
            nerd_font_variant = 'normal',
        },
        sources = {
            default = { 'snippets', 'lsp', 'buffer', 'path' },
            providers = {
                lsp = {
                    async = true,
                    fallbacks = {},
                },
            },
        },
        signature = { enabled = true, window = { show_documentation = false } },
        cmdline = {
            keymap = {
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
            },
            completion = { menu = { auto_show = true } },
        },
    },
}
