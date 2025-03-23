return {
	'echasnovski/mini.nvim',
	version = '*',
	config = function()
		require('mini.files').setup({
			mappings = {
				go_in_plus = '<CR>',
			},
		})
	end,
}
