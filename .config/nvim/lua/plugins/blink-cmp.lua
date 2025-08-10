return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
        {
            'saghen/blink.compat',
            -- use v2.* for blink.cmp v1.*
            version = '2.*',
            lazy = true,
            opts = {},
        },
        {
            'MattiasMTS/cmp-dbee',
            branch = 'ms/v2',
        },
    },
    version = 'v1.*',
    opts = {
        completion = {
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
        snippets = {
            expand = function(snippet)
                require('luasnip').lsp_expand(snippet)
            end,
            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function(direction)
                require('luasnip').jump(direction)
            end,
        },
        sources = {
            default = { 'snippets', 'lsp', 'buffer', 'path' },
            providers = {
                lsp = {
                    async = true,
                    --fallbacks = {},
                },
                dbee = { name = 'dbee', module = 'blink.compat.source' },
            },
            per_filetype = {
                sql = { 'dbee', 'buffer' },
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
