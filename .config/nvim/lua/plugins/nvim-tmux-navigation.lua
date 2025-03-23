return {
	'alexghergh/nvim-tmux-navigation',
	config = function()
		require('nvim-tmux-navigation').setup({})
		vim.keymap.set('n', '<C-s>h', '<Cmd>NvimTmuxNavigateLeft<CR>', {})
		vim.keymap.set('n', '<C-s>j', '<Cmd>NvimTmuxNavigateDown<CR>', {})
		vim.keymap.set('n', '<C-s>k', '<Cmd>NvimTmuxNavigateUp<CR>', {})
		vim.keymap.set('n', '<C-s>l', '<Cmd>NvimTmuxNavigateRight<CR>', {})
	end,
}
