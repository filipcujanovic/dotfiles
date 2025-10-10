return {
    enabled = false,
    'nvim-lualine/lualine.nvim',
    config = function()
        local custom_gruvbox = require('lualine.themes.gruvbox_dark')
        custom_gruvbox.normal.c.bg = 'none'
        custom_gruvbox.insert.c.bg = 'none'
        custom_gruvbox.visual.c.bg = 'none'
        custom_gruvbox.command.c.bg = 'none'
        custom_gruvbox.replace.c.bg = 'none'
        custom_gruvbox.inactive.c.bg = 'none'

        custom_gruvbox.normal.c.fg = '#b8bb26'
        custom_gruvbox.insert.c.fg = '#b8bb26'
        custom_gruvbox.visual.c.fg = '#b8bb26'
        custom_gruvbox.command.c.fg = '#b8bb26'
        custom_gruvbox.replace.c.fg = '#b8bb26'
        custom_gruvbox.inactive.c.fg = '#b8bb26'

        local components = require('lualine.component'):extend()
        function components:init(options)
            components.super.init(self, options)
            self.options = vim.tbl_deep_extend('keep', self.options or {}, {
                fg = '',
                icon = '',
            })
            self.icon = self.options.icon
            self.highlight_color = self:create_hl({ fg = self.options.fg }, 'Rest')
        end

        function components:apply_icon()
            local default_highlight = self:get_default_hl()
            self.status = self:format_hl(self.highlight_color) .. self.icon .. ' ' .. default_highlight .. self.status
        end

        function components.update_status()
            local current_filetype = vim.bo.filetype
            if current_filetype == 'http' then
                return vim.g.kulala_selected_env or require('kulala.config').get().default_env
            end
            return ''
        end

        require('lualine').setup({
            options = {
                icons_enabled = false,
                theme = custom_gruvbox,
            },
            sections = {
                lualine_b = {},
                lualine_x = {
                    components,
                    'encoding',
                    'fileformat',
                    'filetype',
                },
            },
        })
    end,
}
