return {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        workspaces = {
            {
                name = 'the-never-ending-hole',
                path = '~/projects/the-never-ending-hole/',
            },
        },
        new_notes_location = 'current_dir',
        picker = {
            name = 'fzf-lua',
        },
        checkbox = { order = { ' ', 'x' } },
        note_path_func = function(spec)
            local path = spec.dir / tostring(spec.title)
            return path:with_suffix('.md')
        end,
        note_id_func = function(title)
            return title
        end,
    },
}
