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
					require('formatter.filetypes.json').jq,
					function()
						return {
							exe = 'jq',
							args = {
								'--tab',
								'.',
							},
							stdin = true,
						}
					end,
				},
				lua = {
					require('formatter.filetypes.lua').stylua,
					function()
						-- Supports conditional formatting
						if util.get_current_buffer_file_name() == 'special.lua' then
							return nil
						end

						-- Full specification of configurations is down below and in Vim help
						-- files
						return {
							exe = 'stylua',
							args = {
								'--config-path ~/dotfiles/.config/stylua/stylua.toml',
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
