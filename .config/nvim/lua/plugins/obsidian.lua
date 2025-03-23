return {
	'epwalsh/obsidian.nvim',
	version = '*', -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = 'markdown',
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		'nvim-lua/plenary.nvim',
	},
	opts = {
		workspaces = {
			{
				name = 'the never ending hole',
				path = '/Users/cujanovic/Library/Mobile Documents/iCloud~md~obsidian/Documents',
			},
		},
		new_notes_location = 'current_dir',
		picker = {
			name = 'fzf-lua',
		},
		ui = {
			checkboxes = {
				[' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
				['x'] = { char = '', hl_group = 'ObsidianDone' },
			},
		},
	},
}
