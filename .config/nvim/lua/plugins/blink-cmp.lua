return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
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
            default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' },
        },
        signature = { enabled = true, window = { show_documentation = false } },
        cmdline = {
            keymap = {
                ['<Right>'] = { 'accept' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
            },
        },
    },
    opts_extend = { 'sources.default' },
}
