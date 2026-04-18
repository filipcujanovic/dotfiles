return {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
        local colors = require('gruvbox').palette
        local custom_highlights = {
            StatuslineTitle = { bg = 'none', fg = colors.bright_green, bold = true },
            StatuslineSpinner = { bg = 'none', fg = colors.bright_orange, bold = true },
            StatuslineItalic = { bg = 'none', fg = colors.bright_orange, italic = true, bold = true },
            StatuslineModeSeparator = { bg = 'none', fg = colors.bright_orange, bold = true },
            StatuslineModeCommand = { bg = 'none', fg = colors.bright_orange, bold = true },
            StatuslineModeInsert = { bg = 'none', fg = colors.bright_blue, bold = true },
            StatuslineModeNormal = { bg = 'none', fg = colors.bright_green, bold = true },
            StatuslineModeOther = { bg = 'none', fg = colors.bright_red, bold = true },
            StatuslineModeVisual = { bg = 'none', fg = colors.bright_yellow, bold = true },
            TablineSeparator = { bg = 'none', fg = colors.bright_green, bold = true },
        }

        for group, opts in pairs(custom_highlights) do
            vim.api.nvim_set_hl(0, group, opts)
        end
        require('gruvbox').setup({
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },

            overrides = {
                LineNr = { fg = colors.bright_green },
                CursorLineNr = { fg = colors.bright_orange },
                StatusLine = { fg = 'none', bg = 'none' },
                StatusLineNC = { fg = 'none', bg = 'none' },
                TabLineSel = { bg = 'none', fg = colors.bright_orange, bold = true },
                TabLine = { bg = 'none', fg = colors.bright_green, bold = true },
                TabLineFill = { fg = 'none', bg = 'none' },
                WinBar = { fg = 'none', bg = 'none' },
                WinBarNC = { fg = 'none', bg = 'none' },
                --DiagnosticUnderlineHint = { fg = 'none', undercurl = true, sp = '#fb4934', bold = true, bg = '#fb4934' },
                --DiagnosticUnderlineInfo = { fg = 'none', undercurl = true, sp = '#fb4934', bold = true, bg = '#fb4934' },
                DiagnosticUnderlineHint = { fg = 'none', undercurl = true, sp = colors.bright_red },
                DiagnosticUnderlineInfo = { fg = 'none', undercurl = true, sp = colors.bright_red },
                --Whitespace = { fg = '#fb4934' },
            },
            contrast = 'hard',
            transparent_mode = true,
            terminal_colors = true,
            component_separators = '',
            section_separators = '',
        })
        vim.cmd('colorscheme gruvbox')
    end,
}

--return {
--    'ember-theme/nvim',
--    name = 'ember',
--    priority = 1000,
--    config = function()
--        require('ember').setup({
--            variant = 'ember',
--            styles = {
--                comments = { italic = false },
--                keywords = { bold = false },
--                functions = {},
--                types = { bold = true },
--            },
--            on_colors = function(palette)
--                --local palette = {
--                --    base0 = '#151412',
--                --    base1 = '#1c1b19',
--                --    base2 = '#252422',
--                --    base3 = '#2e2d2a',
--                --    base4 = '#3e3c38',
--                --    base5 = '#585550',
--                --    base6 = '#706c61',
--                --    base7 = '#908a7e',
--                --    base8 = '#b8b0a0',
--                --    bg = '#1c1b19',
--                --    bg_alt = '#242320',
--                --    coral = '#e08060',
--                --    fg = '#d8d0c0',
--                --    fg_alt = '#b0a898',
--                --    gold = '#c8b468',
--                --    mauve = '#988090',
--                --    olive = '#8a9868',
--                --    orange = '#c09058',
--                --    rose = '#b07878',
--                --    sage = '#80a090',
--                --    steel = '#7890a0',
--                --    type = 'dark',
--                --}
--                local custom_highlights = {
--                    StatuslineTitle = { bg = 'none', fg = palette.olive, bold = true },
--                    StatuslineSpinner = { bg = 'none', fg = palette.coral, bold = true },
--                    StatuslineItalic = { bg = 'none', fg = palette.coral, italic = true, bold = true },
--                    StatuslineModeSeparator = { bg = 'none', fg = palette.coral, bold = true },
--                    StatuslineModeCommand = { bg = 'none', fg = palette.coral, bold = true },
--                    StatuslineModeInsert = { bg = 'none', fg = palette.steel, bold = true },
--                    StatuslineModeNormal = { bg = 'none', fg = palette.olive, bold = true },
--                    StatuslineModeOther = { bg = 'none', fg = palette.rose, bold = true },
--                    StatuslineModeVisual = { bg = 'none', fg = palette.gold, bold = true },
--                    TablineSeparator = { bg = 'none', fg = palette.olive, bold = true },
--                }
--
--                for group, opts in pairs(custom_highlights) do
--                    vim.api.nvim_set_hl(0, group, opts)
--                end
--
--                return palette
--            end,
--            transparent = true,
--        })
--        vim.cmd('colorscheme ember')
--    end,
--}
