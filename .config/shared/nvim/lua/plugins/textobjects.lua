vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' })
local textobjects = require('nvim-treesitter-textobjects')
local textobjects_move = require('nvim-treesitter-textobjects.move')
local textobjects_select = require('nvim-treesitter-textobjects.select')
local textobjects_swap = require('nvim-treesitter-textobjects.swap')
textobjects.setup({
    select = {
        enable = true,
        lookahead = true,
    },
    move = {
        enable = true,
        set_jumps = true,
    },
    swap = {
        enable = true,
    },
})

vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
    textobjects_move.goto_next_start('@function.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
    textobjects_move.goto_next_start('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
    textobjects_move.goto_next_start('@fold', 'folds')
end)

vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
    textobjects_move.goto_next_end('@function.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
    textobjects_move.goto_next_end('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
    textobjects_move.goto_previous_start('@function.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
    textobjects_move.goto_previous_start('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
    textobjects_move.goto_previous_end('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
    textobjects_move.goto_previous_end('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'af', function()
    textobjects_select.select_textobject('@function.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'if', function()
    textobjects_select.select_textobject('@function.inner', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'ac', function()
    textobjects_select.select_textobject('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'ic', function()
    textobjects_select.select_textobject('@class.inner', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'aa', function()
    textobjects_select.select_textobject('@parameter.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'ia', function()
    textobjects_select.select_textobject('@parameter.inner', 'textobjects')
end)

vim.keymap.set('n', '<leader>a', function()
    textobjects_swap.swap_next('@parameter.inner')
end)

vim.keymap.set('n', '<leader>A', function()
    textobjects_swap.swap_previous('@parameter.outer')
end)
