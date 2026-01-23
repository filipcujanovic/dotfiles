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
                DiagnosticUnderlineHint = { fg = 'none', undercurl = true, sp = '#fb4934' },
                DiagnosticUnderlineInfo = { fg = 'none', undercurl = true, sp = '#fb4934' },
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
