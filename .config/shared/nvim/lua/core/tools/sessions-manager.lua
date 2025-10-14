local has_args = #vim.fn.argv()
local local_dir = vim.fn.getcwd():gsub('[\\/:]+', '%%')
local session_path = string.format('%s/sessions/%s.vim', vim.fn.stdpath('data'), local_dir)

vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        if has_args == 0 then
            vim.cmd('mks! ' .. vim.fn.fnameescape(session_path))
        end
    end,
})

if session_path and vim.fn.filereadable(session_path) ~= 0 then
    if has_args == 0 then
        vim.cmd('silent! source ' .. vim.fn.fnameescape(session_path))
    end
end
